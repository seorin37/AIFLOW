import 'package:flutter/material.dart';
import 'loading.dart'; // 앱 첫 화면으로 보여줄 파일로 연결

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(), // 여기의 위젯 이름을 loading.dart의 첫 화면 위젯 이름으로 맞추기기
    );
  }
}
