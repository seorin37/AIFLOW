# train_contamination.py
import os, re, torch, numpy as np
from PIL import Image
from sklearn.model_selection import train_test_split
from torch.utils.data import Dataset, DataLoader, Subset
import albumentations as A
from albumentations.pytorch import ToTensorV2
import matplotlib.pyplot as plt
from tqdm import tqdm
import torch.nn as nn
import torch.optim as optim
from torch.optim.lr_scheduler import ReduceLROnPlateau
from model_contamination import get_model, BCEDiceLoss

# Dataset
class SegmentationDataset(Dataset):
    def __init__(self, image_dir, mask_dir, transform=None):
        self.image_dir = image_dir
        self.mask_dir = mask_dir
        self.transform = transform

        def extract_key(f): return re.findall(r'\d+', f)[0]

        image_dict = {extract_key(f): f for f in os.listdir(image_dir)}
        mask_dict = {extract_key(f): f for f in os.listdir(mask_dir)}
        common_keys = sorted(set(image_dict.keys()) & set(mask_dict.keys()))
        self.image_files = [image_dict[k] for k in common_keys]
        self.mask_files = [mask_dict[k] for k in common_keys]

    def __len__(self):
        return len(self.image_files)

    def __getitem__(self, idx):
        image_path = os.path.join(self.image_dir, self.image_files[idx])
        mask_path = os.path.join(self.mask_dir, self.mask_files[idx])
        image = np.array(Image.open(image_path).convert("RGB").resize((256, 256)))
        mask = np.array(Image.open(mask_path).convert("L").resize((256, 256)))
        mask = (mask > 127).astype(np.float32)

        if self.transform:
            augmented = self.transform(image=image, mask=mask)
            image = augmented["image"]
            mask = augmented["mask"].unsqueeze(0)
        else:
            image = torch.tensor(image / 255.0, dtype=torch.float).permute(2, 0, 1)
            mask = torch.tensor(mask, dtype=torch.float).unsqueeze(0)

        return image, mask

# 데이터 경로
image_dir = './contamination_dataset/images'
mask_dir = './contamination_dataset/masks'

# 오염 비율 → label 추출
def compute_contamination_ratio(mask_path):
    mask = np.array(Image.open(mask_path).convert("L").resize((256, 256)))
    return (mask > 0).sum() / mask.size

mask_paths = sorted([os.path.join(mask_dir, f) for f in os.listdir(mask_dir)])
labels = [1 if compute_contamination_ratio(p) > 0.01 else 0 for p in mask_paths]

# Stratified Split
train_idx, temp_idx = train_test_split(list(range(len(labels))), test_size=0.3, stratify=labels, random_state=42)
val_labels = [labels[i] for i in temp_idx]
val_idx, test_idx = train_test_split(temp_idx, test_size=1/3, stratify=val_labels, random_state=42)

# Transform
train_transform = A.Compose([
    A.Resize(256, 256), A.HorizontalFlip(), A.VerticalFlip(),
    A.ShiftScaleRotate(shift_limit=0.05, scale_limit=0.1, rotate_limit=20, p=0.5),
    A.RandomBrightnessContrast(p=0.5), A.GaussianBlur(p=0.3),
    A.ElasticTransform(p=0.2), A.Normalize(), ToTensorV2()
])
val_transform = A.Compose([A.Resize(256, 256), A.Normalize(), ToTensorV2()])

full_dataset = SegmentationDataset(image_dir, mask_dir)
train_set = Subset(full_dataset, train_idx)
val_set = Subset(full_dataset, val_idx)
train_set.dataset.transform = train_transform
val_set.dataset.transform = val_transform

# 하이퍼파라미터
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")
BATCH_SIZE = 4
EPOCHS = 60

train_loader = DataLoader(train_set, batch_size=BATCH_SIZE, shuffle=True)
val_loader = DataLoader(val_set, batch_size=BATCH_SIZE)

# 모델 및 학습 설정
model = get_model(DEVICE)
loss_fn = BCEDiceLoss()
optimizer = optim.Adam(model.parameters(), lr=1e-4)
scheduler = ReduceLROnPlateau(optimizer, mode='min', factor=0.5, patience=5)

class EarlyStopping:
    def __init__(self, patience=7, min_delta=0.001):
        self.patience = patience
        self.min_delta = min_delta
        self.counter = 0
        self.best_loss = float('inf')
        self.early_stop = False

    def __call__(self, val_loss):
        if val_loss < self.best_loss - self.min_delta:
            self.best_loss = val_loss
            self.counter = 0
        else:
            self.counter += 1
            if self.counter >= self.patience:
                self.early_stop = True

# 학습 루프
train_losses, val_losses = [], []
early_stopping = EarlyStopping()

def main():
    train_losses, val_losses = [], []
    early_stopping = EarlyStopping()
    best_val_loss = float('inf')

    for epoch in range(EPOCHS):
        model.train()
        running_loss = 0
        for x, y in train_loader:
            x, y = x.to(DEVICE), y.to(DEVICE)
            optimizer.zero_grad()
            pred = model(x)
            loss = loss_fn(pred, y)
            loss.backward()
            optimizer.step()
            running_loss += loss.item()
        avg_train_loss = running_loss / len(train_loader)
        train_losses.append(avg_train_loss)

        model.eval()
        val_loss = 0
        with torch.no_grad():
            for x, y in val_loader:
                x, y = x.to(DEVICE), y.to(DEVICE)
                pred = model(x)
                val_loss += loss_fn(pred, y).item()
        avg_val_loss = val_loss / len(val_loader)
        val_losses.append(avg_val_loss)

        print(f"Epoch {epoch+1} | Train Loss: {avg_train_loss:.4f} | Val Loss: {avg_val_loss:.4f}")

        if avg_val_loss < best_val_loss:
            best_val_loss = avg_val_loss
            torch.save(model.state_dict(), "best_contamination_model.pth")
            print("💾 Best model updated!")

        old_lr = optimizer.param_groups[0]['lr']
        scheduler.step(avg_val_loss)
        new_lr = optimizer.param_groups[0]['lr']
        if new_lr != old_lr:
            print(f"🔁 LR reduced: {old_lr:.6f} → {new_lr:.6f}")

        early_stopping(avg_val_loss)
        if early_stopping.early_stop:
            print(f"⛔ Early stopping triggered at epoch {epoch+1}")
            break

    # Loss 시각화
    def moving_average(data, window=3):
        return np.convolve(data, np.ones(window) / window, mode='valid')

    plt.figure(figsize=(10, 5))
    plt.plot(moving_average(train_losses), label="Train Loss")
    plt.plot(moving_average(val_losses), label="Validation Loss")
    plt.title("Smoothed Loss Curve")
    plt.xlabel("Epoch")
    plt.ylabel("Loss")
    plt.grid()
    plt.legend()
    plt.tight_layout()
    plt.savefig("val_results_ctm")

if __name__ == "__main__":
    main()