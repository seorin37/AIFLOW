import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'paper1.dart';
import 'CleanResult.dart';
import 'DirtyResult.dart';
import 'VinylResult.dart';
import 'SlightDirtyResult.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  // 사용 가능한 카메라를 설정하고 초기화하는 함수
  Future<void> _setupCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        _showNoCameraDialog();
        return;
      }

      _controller = CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      print('❌ 카메라 초기화 오류: $e');
      _showNoCameraDialog();
    }
  }

  // 카메라가 없을 때 사용자에게 경고창을 띄우는 함수
  void _showNoCameraDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('카메라 없음'),
        content: const Text('사용 가능한 카메라가 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  // 이미지를 촬영하고 Flask 서버로 전송하는 함수
  Future<void> _captureAndSendImage() async {
    try {
      print("촬영버튼 클릭");
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.20.10.13:5000/upload'), // 실제 서버 주소로 바꾸기
      );

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString(); // stream을 String으로 변환

      if (response.statusCode == 200) {
        print('✅ 이미지 전송 성공');
        print('📦 서버 응답: $responseBody'); // 결과 출력
        // 응답 결과에 따라 페이지 이동
      if (responseBody.contains('"result":"paper"')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaperResultScreen()),
        );
      } 
      if (responseBody.contains('"result":"plastic_clean"')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CleanResultScreen()),
        );
      } 
      if (responseBody.contains('"result":"plastic_slight"')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SlightDirtyResultScreen()),
        );
      } 
      if (responseBody.contains('"result":"plastic_heavy"')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DirtyResultScreen()),
        );
      } 
      if (responseBody.contains('"result":"plastic_with_vinyl')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VinylResultScreen()),
        );
      } 
      else {
        print('⚠ 예상치 못한 응답: $responseBody');
        // 필요 시 다른 페이지로도 이동 가능
      }
      } else {
        print('❌ 전송 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ 사진 전송 오류: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_initializeControllerFuture == null)
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      CameraPreview(_controller!),

                      // 가이드 회색 패딩 (사각형 형태)
                      Align(
                        alignment: Alignment.center,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final height = constraints.maxHeight;
                            final guideSize = width * 0.7; // 사각형 크기 (화면의 70%)
                            final borderThickness = 60.0; // 패딩 두께

                            return Stack(
                              children: [
                                // 왼쪽 패딩
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  width: (width - guideSize) / 2,
                                  child: Container(color: Colors.grey.withOpacity(0.7)),
                                ),
                                // 오른쪽 패딩
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  width: (width - guideSize) / 2,
                                  child: Container(color: Colors.grey.withOpacity(0.7)),
                                ),
                                // 상단 패딩
                                Positioned(
                                  top: 0,
                                  left: (width - guideSize) / 2,
                                  right: (width - guideSize) / 2,
                                  height: (height - guideSize) / 2,
                                  child: Container(color: Colors.grey.withOpacity(0.7)),
                                ),
                                // 하단 패딩
                                Positioned(
                                  bottom: 0,
                                  left: (width - guideSize) / 2,
                                  right: (width - guideSize) / 2,
                                  height: (height - guideSize) / 2,
                                  child: Container(color: Colors.grey.withOpacity(0.7)),
                                ),
                                // 안내 문구
                                Align(
                                  alignment: const Alignment(0, -0.5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    color: Colors.white.withOpacity(0.7),
                                    child: const Text(
                                      '사각형 안에 물체를 맞춰주세요!',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // 촬영 버튼
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: GestureDetector(
                            onTap: _captureAndSendImage,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 36,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
