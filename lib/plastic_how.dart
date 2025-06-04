import 'package:flutter/material.dart';

/*void main() {
  runApp(const MyApp());
}

// 전체 앱 구조 정의
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlasticHowScreen(), // 첫 화면으로 PlasticHowScreen 지정
    );
  }
}*/

// "PLASTIC" 분리수거 안내 화면
class PlasticHowScreen extends StatelessWidget {
  const PlasticHowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6E9), // 연한 연두 배경
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 뒤로가기 버튼
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Color(0xFF88B087),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 타이틀
              const Text(
                'PLASTIC',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(height: 20),

              // 플라스틱 병 아이콘
              Image.asset(
                 'assets/bottle.png',
                width: 74,
                height: 74,
              ),
              const SizedBox(height: 36),

              // 분리수거 방법
              const Text(
                '올바른 분리수거 방법\n\n'
                '1. 음식물, 이물질 제거\n'
                '2. 용기 세척\n'
                '3. 비닐 제거\n'
                '4. 압축\n'
                '5. 분리수거',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),

              // 안내 문구
              const Text(
                '음식물이 제거되지 않은 배달용기는\n'
                '분리수거가 불가능합니다!\n\n'
                '배달용기 세척 기준은\n'
                '각 구청, 시청 별로 상이하니\n'
                '꼭 지역의 기준을 확인해주세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.7,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
