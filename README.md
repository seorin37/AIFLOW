# AIFLOW


# ♻️ 분리수거 도우미 Flutter 앱

이 Flutter 앱은 사용자가 배달 음식 용기의 오염 정도를 촬영하고, AI 모델이 이를 분석하여 **분리수거 가능 여부**를 알려주는 환경 교육용 어플리케이션입니다.  
각 소재별(종이, 비닐, 플라스틱 등) 올바른 배출 방법도 함께 안내합니다.

---

## 📱 주요 기능

- **카메라 촬영 및 AI 분석 결과 전송**
- **분리수거 분류 결과에 따라 다른 결과 화면(Clean / Slightly Dirty / Dirty) 출력**
- **종이/비닐/플라스틱 각각의 분리배출 가이드 제공**
- **닉네임 설정 및 유지 기능 (SharedPreferences 사용)**

---

## 📁 프로젝트 구조

```
lib/
├── main.dart                      # 앱 진입점
├── Mainpage.dart                  # 메인화면: 버튼 4개(촬영, 가이드 등)
├── camera_screen.dart             # 카메라 실행 및 서버 통신
├── loading.dart                   # 이미지 분석 결과 로딩 화면
├── CleanResult.dart               # 결과 - 깨끗한 상태
├── SlightDirtyResult.dart         # 결과 - 약간 오염
├── DirtyResult.dart               # 결과 - 심각한 오염
├── VinylResult.dart               # 결과 - 비닐 전용 결과
├── paper1.dart                    # 종이 배출 정보
├── paper_how.dart                 # 종이 배출 가이드
├── plastic_how.dart               # 플라스틱 배출 가이드
├── vinyl_how.dart                 # 비닐 배출 가이드
├── how.dart                       # 공통 가이드 진입점
├── Nickname.dart                  # 닉네임 설정 및 저장 (SharedPreferences)
├── pubspec.yaml                   # 의존성 정의
```

---

## 🚀 실행 방법

```bash
# 1. 의존성 설치
flutter pub get

# 2. 앱 실행 (디바이스 연결 또는 에뮬레이터 필요)
flutter run
```

> ⚠️ iOS 디바이스에서 실행하려면 Xcode 설정 및 권한 요청 필요  
> ⚠️ Android에서는 카메라 권한 및 서버 연동 URL 확인 필요

---

## 🔧 사용된 주요 패키지

- `camera` – 카메라 제어
- `http` – 이미지 서버 전송 및 응답 수신
- `shared_preferences` – 사용자 정보 저장
- `http_parser` – 서버 요청의 MIME 타입 처리

---

## 📡 서버 연동

`camera_screen.dart` 파일에서 촬영된 이미지는 서버로 전송되며,  
서버는 오염도 분석 결과(`clean`, `slight_dirty`, `dirty`)를 반환합니다.  
이 결과에 따라 각기 다른 결과 화면으로 이동합니다.

---

## 📸 UI 예시

- 메인화면: 4개의 버튼 (촬영, 분리배출법, 닉네임 설정 등)
- 카메라 뷰: 실시간 카메라 피드
- 결과화면: 오염도 결과에 따른 세분화된 안내
- 배출가이드: 소재별 그림과 함께 배출 방법 설명

---

## 👤 개발자 정보

- 소속: 성신여자대학교 AI융합학부
- 프로젝트: 캡스톤디자인 (AI 기반 분리배출 도우미 앱)
- 개발 플랫폼: Flutter + Dart
- 목적: 분리배출의 효율성과 시민 참여 향상

---

## ✅ TODO (향후 개선점)

- [ ] 서버 주소 외부 설정화
- [ ] 배출 안내 애니메이션 추가
- [ ] 점수제 도입 및 사용자 참여 유도
- [ ] 결과 화면 UI 개선 및 반응형 지원
