import 'package:flutter/material.dart';
import 'Mainpage.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VinylResultScreen(), // 첫 화면 지정
    );
  }
}*/

class VinylResultScreen extends StatelessWidget {
  const VinylResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경 흰색
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙 정렬
          children: [
            // 연녹색 박스
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 64),
                decoration: BoxDecoration(
                  color: const Color(0xFFA7C6A1), // 연녹색 배경
                  borderRadius: BorderRadius.circular(32), // 둥근 모서리
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.delete_forever_outlined, // 투명 휴지통
                      size: 70,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '비닐 있음\n비닐을 제거하고\n분리수거 해주세요',
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

            // 홈 버튼
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                size: 32,
                color: Color(0xFFA7C6A1), // 연녹색 아이콘
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