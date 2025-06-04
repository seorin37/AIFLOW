import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Mainpage.dart'; // 메인 페이지 import

class Nickname extends StatefulWidget {
  const Nickname({super.key});

  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _saveAndGoNext() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', _controller.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF92C59C),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 마스코트 + 텍스트 Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/char.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '\n \n Log In',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'font11',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // 텍스트 입력창
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'ID',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 확인 버튼
              ElevatedButton(
                onPressed: _saveAndGoNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontFamily: 'nanum'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
