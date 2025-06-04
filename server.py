# server.py
from flask import Flask, request, jsonify
from PIL import Image
import torch
import torchvision.transforms as transforms
import numpy as np
import io

from clf_model import predict_material
from vinyl_model import detect_vinyl
from ctm_model import predict_dirty_level

app = Flask(__name__)

@app.route('/upload', methods=['POST'])
def upload():
    if 'image' not in request.files:
        return jsonify({'error': '이미지가 없습니다'}), 400

    file = request.files['image']
    image = Image.open(file.stream).convert('RGB')

    # 1단계: 종이/플라스틱 분류
    material = predict_material(image)

    if material == 'paper':
        return jsonify({'result': '종이입니다. 음식물이 묻지 않은 상자라면 재활용 가능합니다. 음식물(기름) 묻은 종이는 일반쓰레기에 버리세요.'})

    # 2단계: 플라스틱 → 비닐 여부 판별
    vinyl_attached = detect_vinyl(image)

    if vinyl_attached:
        return jsonify({'result': '플라스틱 용기에서 비닐이 감지되었습니다. 비닐을 제거하고 다시 이미지를 업로드 해주세요.'})

    # 3단계: 오염도 평가
    contamination_level = predict_dirty_level(image)

    result_message = {
        'clean': '✅ 깨끗합니다. 재활용 가능합니다!',
        'slight': '⚠️ 살짝 오염되어 있습니다. 물로 헹군 후 재활용하세요.',
        'heavy': '🚫 심하게 오염되어 재활용 불가능합니다. 세척 후 이미지를 다시 업로드 해주세요.'
    }

    return jsonify({'result': result_message[contamination_level]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)