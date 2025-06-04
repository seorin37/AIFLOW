# AIFLOW
# server.py
"server.py"에 clf_model.py, ctm_model.py, vinyl_model 파일들 불러오기

from clf_model import predict_material
from vinyl_model import detect_vinyl
from ctm_model import predict_dirty_level

# 1. clf_model.py (predict_material)
from model_classification import get_model
분류 모델 불러와서 예측하였을 때 결과를 0: plastic, 1: paper로 이진 분류함.

# 2. vinyl_model.py (detect_vinyl)
from model_vinyl import get_model

비닐 감지 모델 불러와서 예측하였을 때 vinyl_ratio>=0.02면, return True(비닐 있음).

# 2. ctm_model.py (predict_dirty_level)
from model_contamination import get_model

오염도 예측 모델 불러와서 예측하였을 때

contamination을 오염도 기준 분류 함수(classify_contamination)에 따라서 clean, slight, heavy로 구분함.

def classify_contamination(contamination: float) -> str:
    if contamination < 0.01:
        return 'clean'
    elif contamination < 0.20:
        return 'slight'
    else:
        return 'heavy'

