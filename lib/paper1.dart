import 'package:flutter/material.dart';
import 'Mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaperResultScreen(), // 첫 화면
    );
  }
}

class PaperResultScreen extends StatelessWidget {
  const PaperResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경은 흰색
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 연녹색 안내 박스
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 64),
                decoration: BoxDecoration(
                  color: const Color(0xFFA7C6A1), // 연녹색
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.description_outlined, // 문서 아이콘
                      size: 70,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '종이\n오염되지 않은 종이만\n분리수거 가능!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),

            // 홈 아이콘 버튼
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                size: 32,
                color: Color(0xFFA7C6A1), // 연녹색
              ),
              onPressed: () {
                    Navigator.push( 
                      context, 
                      MaterialPageRoute(builder: (context) => MainPage()),);
                    debugPrint("홈으로 이동");
                  },
            ),
          ],
        ),
      ),
    );
  }
}
