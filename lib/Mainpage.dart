// Mainpage.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // 추가
import 'camera_screen.dart'; // 추가
import 'package:shared_preferences/shared_preferences.dart';
import 'how.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _nickname = "";

  Future<void> _loadNickname() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nickname = prefs.getString('nickname') ?? '사용자';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNickname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),

            // 사용자 정보 카드
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F6DC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_circle, size: 45),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: $_nickname",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'font11',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset('assets/char.png', height: 60),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 190),

            // HOW 버튼
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HowToRecycleScreen(),
                  ),
                );
              },
              child: Container(
                width: 230,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF92C59C),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.help_outline, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      'HOW',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'font11',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CAMERA 버튼 
            GestureDetector(
              onTap: () async {
                // 카메라 목록 가져오기
                final cameras = await availableCameras();

                // 카메라 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(),
                  ),
                );
              },
              child: Container(
                width: 230,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF92C59C),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.camera_alt, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      'CAMERA',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'font11',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
