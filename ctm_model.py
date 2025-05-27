# ctm_model.py
import torch
from torchvision import transforms
from PIL import Image
import numpy as np

model = torch.load("best_contamination_model.pth", map_location='cpu')
model.eval()

transform = transforms.Compose([
    transforms.Resize((256, 256)),
    transforms.ToTensor()
])

def predict_dirty_level(img: Image.Image) -> str:
    img_tensor = transform(img).unsqueeze(0)
    with torch.no_grad():
        pred_mask = model(img_tensor)
        mask = torch.sigmoid(pred_mask).squeeze().numpy()

    contamination = (mask > 0.5).mean()

    if contamination < 0.05:
        return 'clean'
    elif contamination < 0.2:
        return 'slight'
    else:
        return 'heavy'