## ♻️ 쓰담쓰담 (SSUDAM-SSUDAM)

![프로젝트 배너 또는 로고](path/to/logo.png)

---
  
## 📌 프로젝트 개요

**프로젝트명:** 쓰담쓰담  
**팀명:** AIFlOW  
**팀원:**  
- 홍길동 (팀장)  
- 김철수 (백엔드, 모델)  
- 이영희 (프론트엔드, UI/UX)  
- … (추후 추가)  

**개발 기간:** 2025.03.25 ~ 2025.06.10  

**프로젝트 소개:**  
> 배달용기의 재질과 오염도를 인공지능으로 판별하여  
> 사용자가 정확한 분리수거 방법을 손쉽게 알 수 있도록 돕는  
> AI 기반 분리수거 가이드 애플리케이션입니다.  



---

## 🎯 목표 및 배경

1. **서비스 목적**  
   - 배달 주문량 증가로 인해 배달용기를 어떻게 분리수거해야 하는지 혼란을 겪는 사용자에게  
     사진 한 장으로 ‘플라스틱 vs 종이 vs 비닐’, 그리고 ‘오염도(이염도)’ 정보를 제공  
   - 최종적으로 지역별 분리수거 규정에 맞춘 가이드까지 추천

2. **사용 대상**  
   - 분리수거 기준이 헷갈리거나 익숙하지 않은 일반 사용자  
   - 특히 배달·포장 문화가 발달한 도심 거주자 및 1인 가구를 주요 타깃으로 설정  

3. **주요 기능 요약**  
   1. 카메라 촬영을 통한 실시간 AI 분류(플라스틱/종이/비닐)  
   2. 오염도(이염도) 판별:  
      - 비닐 동봉 여부  
      - 플라스틱 표면 오염(남은 음식물, 기름) 유무  
   3. 지역별 분리수거 규정 안내(추후 연동 예정)  
   4. 사용자가 촬영한 이미지 수집·라벨링(마스크 포함) 자동화  
   5. Flutter/Dart 기반 모바일 UI 구현  


---

## 📌 기술 스택

- **환경 (Environment)**  
  - IDE: Visual Studio Code  
  - 버전 관리: Git, GitHub  
  - 커뮤니케이션: Notion, Zoom  

- **개발 (Development)**  
  - AI 프레임워크: PyTorch  
  - 모바일 앱: Flutter, Dart  
  - 백엔드 서버(추후 확장): FastAPI (예정)  
  - 데이터베이스(추후 확장): Firebase Firestore (예정)  

- **디자인 (Design)**  
  - UI/UX: Figma  
  - 아이콘: Material Icons, 자체 제작 PNG/SVG  

---

## 🔍 파일 및 디렉터리 구조 (예시)

> **Tip:** 실제 저장소 구조에 맞춰 디렉터리 이름이나 파일명을 조정하세요.

---

## 🚀 주요 기능 (Features)

1. **이미지 라벨링/마스크 처리 (Data Labeling)**  
   - 배달용기(플라스틱, 종이)와 오염도 라벨링  
   - Python + OpenCV 기반 자동 마스크 생성 스크립트  

2. **종이 vs 플라스틱 분류 모델 (Paper vs Plastic Classifier)**  
   - 이미지 전처리(Resize, Normalize) 후 PyTorch 모델 학습  
   - `models/classification/train_script.py`에서 학습 파이프라인 구현  
   - Test Accuracy: xx.xx% (2025.06 기준)

3. **플라스틱 내 비닐 동봉 여부 분류 모델 (Vinyl Detection)**  
   - 플라스틱 영역에서 비닐 유무 판별  
   - 배경 제거 후 특징 추출(FEATURE_MAP) → 이진 분류  

4. **플라스틱 오염도(이염도) 판별 모델 (Dirt/Contamination Detector)**  
   - “깨끗함(재활용 가능)” vs “매우 더러움(재활용 불가)” 구분  
   - Sobel Edge Filter 기반 엣지 검출 → 오염도 점수화  

5. **카메라 실시간 촬영 및 서버 전송 (Camera & API)**  
   - Flutter 기반 카메라 화면 구현 (`mobile_app/lib/screens/camera_screen.dart`)  
   - 촬영된 이미지를 서버(또는 로컬 PyTorch 추론 엔드포인트)로 전송  
   - 전송 후 분류 결과 리턴 → 결과 화면(`result_screen.dart`)에 표시  

6. **UI/UX 디자인 (Design)**  
   - 심플한 친환경 컬러 팔레트(연녹색)  
   - 직관적인 아이콘 배치 (Figma 디자인 시안 첨부)  
   - 로딩 화면, 로그인 화면, 분리수거 가이드 화면 등 전체 흐름 설계  


---

## 📸 스크린샷 (Screenshots)

### 1) Splash & Login

| Splash 화면 (로고) | 로그인 화면 |
|:-----------------:|:----------:|
| <img src="mobile_app/assets/images/splash.png" width="200"/> | <img src="mobile_app/assets/images/login.png" width="200"/> |

### 2) 메인 & 카메라 촬영

| 메인 화면 (사용자 ID) | 카메라 촬영 화면 |
|:-------------------:|:----------------:|
| <img src="mobile_app/assets/images/main.png" width="200"/> | <img src="mobile_app/assets/images/camera.png" width="200"/> |

### 3) 분리수거 가이드 (결과 화면)

| 플라스틱 깨끗함 | 플라스틱 오염 | 비닐 포함 | 종이 |
|:-------------:|:----------:|:-------:|:---:|
| <img src="mobile_app/assets/images/clean1.png" width="150"/> | <img src="mobile_app/assets/images/dirty1.png" width="150"/> | <img src="mobile_app/assets/images/vinyl1.png" width="150"/> | <img src="mobile_app/assets/images/paper1.png" width="150"/> |

> **Tip:** `mobile_app/assets/images/` 폴더에 실제 캡처 이미지를 추가하고, 경로를 맞춰주세요. 

