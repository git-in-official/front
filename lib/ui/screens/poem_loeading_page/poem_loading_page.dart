import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_morrow_front/repository/controller/auth_service.dart';

class PoemLoadingPage extends StatefulWidget {
  const PoemLoadingPage({super.key});



  @override
  State<PoemLoadingPage> createState() => _PoemLoadingPageState();
}

class _PoemLoadingPageState extends State<PoemLoadingPage> {
  int stage = 0;
  Timer? timer;
  int remainingEdits = 1; // 오늘 가능한 탈고 횟수
  String name = ''; // 사용자 이름 저장 변수
  final AuthService _authService = AuthService(); // AuthService 인스턴스 생성

  @override
  void initState() {
    super.initState();
    _loadUserName(); // 사용자 이름 로드
    startAnimation();
  }

  Future<void> _loadUserName() async {
    String? loadedName = await _authService.loadServiceName();
    setState(() {
      name = loadedName ?? '회원'; // 이름이 없으면 '회원'으로 표시
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startAnimation() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        stage = (stage + 1) % 3; // "교 -> 교정 -> 교정중" 반복
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    switch (stage) {
      case 0:
        text = '교';
        break;
      case 1:
        text = '교정';
        break;
      case 2:
        text = '교정중';
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 115),
              SvgPicture.asset(
                'assets/icons/poem_loading/poem_loading_logo.svg',
                width: 64,
                height: 64,
              ),
              const SizedBox(height: 24),
              Text(
                '$name님의 작품이 \n'
                    '교정과 교열에 들어갔습니다.\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'KoPubBatangPro',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF373430),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '인쇄가 완료되면\n'
                    '내일의 누군가를 위해\n'
                    '작품이 출판됩니다.\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'KoPubBatangPro',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF373430),
                ),
              ),
              const SizedBox(height: 98),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '집필 > 탈고 > ',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'KoPubBatangPro',
                      color: Color(0xFF373430),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 38,
                    child: Text(
                      text,
                      key: ValueKey<int>(stage),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'KoPubBatangPro',
                        color: Color(0xFF373430),
                      ),
                    ),
                  ),
                  const Text(
                    ' > 교열 > 인쇄 > 출판',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'KoPubBatangPro',
                      color: Color(0xFFB8B4AD),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 54),
              Stack(
                // Stack의 영역을 넘어가도 잘리지 않도록
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF373430),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFE6E2DB),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'KoPubBatangPro',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E2DB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF373430),
                          width: 1.0,
                        ),
                      ),
                      height: 20.0,
                      width: 142.0,
                      alignment: Alignment.center,
                      child: Text(
                        '오늘 가능한 탈고 횟수: $remainingEdits회',
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'KoPubBatangPro',
                          color: Color(0xFF373430),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
