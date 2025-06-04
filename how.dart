import 'package:flutter/material.dart';
import 'Mainpage.dart';
import 'paper_how.dart';
import 'plastic_how.dart';
import 'vinyl_how.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HowToRecycleScreen(),
    );
  }
}*/

class HowToRecycleScreen extends StatelessWidget {
  const HowToRecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6E9), // 연한 연두 배경
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32), // 여백 약간 넓힘
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 홈 아이콘
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.home_outlined,
                    size: 28,
                    color: Color(0xFFA7C6A1),
                  ),
                  onPressed: () {
                    Navigator.push( 
                      context, 
                      MaterialPageRoute(builder: (context) => const MainPage()),);
                    debugPrint("홈으로 이동");
                  },
                ),
              ),
              const SizedBox(height: 36), // 상단 간격 늘림

              // 타이틀
              const Text(
                'How to recycle',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(height: 28), // 타이틀과 아이콘 사이 간격 증가

              // 리사이클 아이콘
              const Icon(
                Icons.recycling,
                size: 64,
                color: Colors.black,
              ),
              const SizedBox(height: 36),

              // 설명 텍스트
              const Text(
                '1. 분리수거 할 배달용기를\n중앙에 맞춰 사진을 찍어주세요!\n\n2. 쓰담쓰담이 배달용기의\n분리수거 가능 여부를 판단해줍니다!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),

              // 버튼 3개
              RecycleButton(text: 'PLASTIC'),
              const SizedBox(height: 20),
              RecycleButton(text: 'PAPER'),
              const SizedBox(height: 20),
              RecycleButton(text: 'VINYL'),
            ],
          ),
        ),
      ),
    );
  }
}

// 재사용 가능한 버튼 위젯
class RecycleButton extends StatelessWidget {
  final String text;

  const RecycleButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          debugPrint('$text 버튼 눌림');

          // TODO: 이후 여기에 각 버튼에 따라 다른 안내 페이지로 이동 추가하기
          // 예:
           if (text == 'PAPER') {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const PaperHowScreen()));
           }
           if (text == 'PLASTIC') {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const PlasticHowScreen()));
           }
           if (text == 'VINYL') {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const VinylHowScreen()));
           }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA7C6A1), // 연녹색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22), // pill 형태
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
