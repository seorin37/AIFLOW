# vinyl_model.py
import torch
from torchvision import transforms
from PIL import Image
import numpy as np

model = torch.load("best_vinyl_model.pth", map_location='cpu')
model.eval()

transform = transforms.Compose([
    transforms.Resize((256, 256)),
    transforms.ToTensor()
])

def detect_vinyl(img: Image.Image) -> bool:
    img_tensor = transform(img).unsqueeze(0)
    with torch.no_grad():
        pred_mask = model(img_tensor)
        mask = torch.sigmoid(pred_mask).squeeze().numpy()
    vinyl_ratio = (mask > 0.5).mean()
    return vinyl_ratio > 0.05  # 비닐이 일정 이상 있으면 True