import 'package:flutter/material.dart';

/*void main() {
  runApp(const MyApp());
}

// 앱 루트
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaperHowScreen(),
    );
  }
}*/

// Paper 분리수거 안내 페이지
class PaperHowScreen extends StatelessWidget {
  const PaperHowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6E9), // 연한 연두 배경
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32), // 전체 여백 확대
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
                'PAPER',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(height: 20),

              // 종이 아이콘
              const Icon(
                Icons.description_outlined,
                size: 74,
                color: Colors.black,
              ),
              const SizedBox(height: 40),

              // 분리수거 안내 텍스트
              const Text(
                '영수증, 전표\n'
                '코팅된 종이\n'
                '기름이나 양념 묻은 종이\n'
                '↓\n'
                '분리수거 불가!   일반쓰레기\n\n'
                '깨끗한 종이 (신문, 책 등)\n'
                '↓\n'
                '분리수거 가능!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 2.0, // 줄 간격 넓힘
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
