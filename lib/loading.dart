import 'package:flutter/material.dart'; // 플러터의 기본 UI 위젯 패키지
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences
import 'package:http/http.dart' as http; // http 추가!
import 'package:http_parser/http_parser.dart'; // http_parser 추가!

import 'Mainpage.dart'; // 메인 페이지
import 'Nickname.dart'; // 닉네임 입력 페이지
///import 'DirtyResult.dart';

// 앱의 시작점
void main() {
  runApp(const Loading()); // 앱 실행
}

// 전체 앱 구조 정의
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 메인 화면 위젯
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // 서버 데이터 요청 예제 함수
  Future<void> fetchData() async {
    final url = Uri.parse('https://example.com/api/data'); // 🔹 실제 서버 URL로 변경!

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('서버 응답: ${response.body}');
      } else {
        print('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('요청 중 오류 발생: $e');
    }
  }

  // 아이콘 클릭 시 SharedPreferences 확인 및 분기
  Future<void> _handleIconTap(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final nickname = prefs.getString('nickname');

    // 서버 요청 호출 (예제: 앱 시작 시 서버 데이터 확인)
    await fetchData();

    if (nickname != null && nickname.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
        ///MaterialPageRoute(builder: (context) => DirtyResultScreen()), // 테스트용
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Nickname()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF92C59C),
      appBar: AppBar(
        title: const Text('Main화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _handleIconTap(context),
              child: Image.asset(
                'assets/char.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 1),
            const Text(
              '쓰담쓰담',
              style: TextStyle(fontFamily: 'nanum', fontSize: 60),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('nickname');
                print("✅ 닉네임 초기화됨");
              },
              child: const Text("닉네임 초기화"),
            ),
          ],
        ),
      ),
    );
  }
}
