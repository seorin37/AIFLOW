# AIFLOW
### server.py - Flask 기반 이미지 분류 APIFlask 기반 이미지 분류 API
이미지를 기반으로 아래의 3단계 분류 과정을 거쳐 **재질과 오염 상태**를 판단하는 Flask 서버

1. **종이 vs 플라스틱** 분류  
2. **플라스틱일 경우 비닐 유무 감지**  
3. **비닐이 없을 경우 오염도 평가 (clean / slight / heavy)**

**📖 API 사용법**
"server.py"에 clf_model.py, ctm_model.py, vinyl_model 파일들 불러오기

from clf_model import predict_material
from vinyl_model import detect_vinyl
from ctm_model import predict_dirty_level

플러터에서 이미지 업로드 후 예측 결과를 JSON 형식으로 반환
응답 형태
# 종이: {"result": "paper"}
# 비닐있는 플라스틱: {"result": "plastic_with_vinyl"}
# 비닐없는 플라스틱 오염도 평가: {"result": "plastic_clean" //또는 plastic_slight, plastic_heavy}


### 1. clf_model.py (predict_material)
from model_classification import get_model
분류 모델 불러와서 예측하였을 때 결과를 0: plastic, 1: paper로 이진 분류함.

### 2. vinyl_model.py (detect_vinyl)
from model_vinyl import get_model

비닐 감지 모델 불러와서 예측하였을 때 vinyl_ratio>=0.02면, return True(비닐 있음).

### 2. ctm_model.py (predict_dirty_level)
from model_contamination import get_model

오염도 예측 모델 불러와서 예측하였을 때
contamination을 오염도 기준 분류 함수(classify_contamination)에 따라서 "clean, slight, heavy"로 구분함.

def classify_contamination(contamination: float) -> str:
    if contamination < 0.01:
        return 'clean'
    elif contamination < 0.20:
        return 'slight'
    else:
        return 'heavy'

