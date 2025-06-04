import 'package:flutter/material.dart';

/*void main() {
  runApp(const MyApp());
}

// 루트 앱 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VinylHowScreen(),
    );
  }
}*/

// 비닐 분리수거 안내 화면
class VinylHowScreen extends StatelessWidget {
  const VinylHowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6E9), // 연한 연두 배경
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ← 뒤로 가기 버튼
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF88B087),
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 32),

              // 타이틀
              const Text(
                'VINYL',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(height: 20),

              // 비닐(장바구니) 아이콘
              Image.asset(
                 'assets/vinylbag.png',
                width: 74,
                height: 74,
              ),
              const SizedBox(height: 40),

              // 올바른 분리수거 방법 안내
              const Text(
                '올바른 분리수거 방법\n\n'
                '1. 내용물 제거\n'
                '2. 이물질 제거\n'
                '3. 분리수거',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 2.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),

              // 주의사항 안내
              const Text(
                '양념이나 오염물, 물 등\n'
                '오염된 비닐은 일반 쓰레기로\n'
                '버려주세요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
