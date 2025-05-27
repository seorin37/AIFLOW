# clf_model.py
import torch
from torchvision import transforms
from PIL import Image

model = torch.load("best_classification_model.pth", map_location='cpu')
model.eval()

transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor()
])

def predict_material(img: Image.Image) -> str:
    input_tensor = transform(img).unsqueeze(0)
    with torch.no_grad():
        output = model(input_tensor)
        pred = torch.argmax(output, 1).item()
    return 'paper' if pred == 0 else 'plastic'