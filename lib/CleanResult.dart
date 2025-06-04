import 'package:flutter/material.dart';
import 'Mainpage.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CleanResultScreen(),
    );
  }
}*/

class CleanResultScreen extends StatelessWidget {
  const CleanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 재활용 박스
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
                      Icons.recycling,
                      size: 70,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '깨끗함!\n재활용 가능',
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
            const SizedBox(height: 80),

            // 홈 버튼
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
