import 'package:flutter/material.dart';
import 'Mainpage.dart';

/*void main() {
  runApp(const MyApp());
}

/// 앱 시작 진입점
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DirtyResultScreen(), // 앱 시작 시 보여줄 화면
    );
  }
}*/

/// "매우 더러움 / 재활용 불가" 결과 화면
class DirtyResultScreen extends StatelessWidget {
  const DirtyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 연녹색 박스 영역
            Center(
              child: Container(
                width: 220,
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 64),
                decoration: BoxDecoration(
                  color: const Color(0xFFA7C6A1), // 연녹색
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // 휴지통 아이콘
                    Icon(
                      Icons.delete_forever_outlined, // 또는 Icons.block
                      size: 70,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    // 텍스트
                    Text(
                      '매우 더러움\n재활용 불가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 하단 홈 버튼
            const SizedBox(height: 80),
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
