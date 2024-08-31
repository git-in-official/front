import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/auth_service.dart';
import 'package:to_morrow_front/repository/controller/finish_writing_poem.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';

class PoemLoadingPage extends StatefulWidget {
  const PoemLoadingPage({super.key});



  @override
  State<PoemLoadingPage> createState() => _PoemLoadingPageState();
}

class _PoemLoadingPageState extends State<PoemLoadingPage> {
  int stage = 0;
  Timer? timer;
  String name = ''; // 사용자 이름 저장 변수
  final AuthService _authService = AuthService();
  final FinishWritingPoem _finishWritingPoem = Get.put(FinishWritingPoem());
  final MainTabController tabController = Get.find();
  bool isSendingComplete = false;

  @override
  void initState() {
    super.initState();
    _loadUserName(); // 사용자 이름 로드
    startAnimation();
    _sendPoemData();
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

  Future<void> _sendPoemData() async {
    print("시 정보를 서버로 전송 중입니다..."); // 전송 시작 시 메시지 출력
    _finishWritingPoem.remainingEdits.value = 10;

    await _finishWritingPoem.donePoem(); // 서버로 데이터 전송

    setState(() {
      isSendingComplete = true; // 전송 완료 시 상태 업데이트
    });

    if (isSendingComplete) {
      print("시 정보 전송이 완료되었습니다.");
    } else {
      print("시 정보 전송에 실패했습니다.");
    }
  }

  // 확인 누르면 메인으로 이동
  void _onConfirmPressed() {
    if (isSendingComplete) {
      tabController.pageName.value = 'Home';
    }
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
                      // 서버 전송 완료되면 버튼 활성화
                      onPressed: isSendingComplete ? _onConfirmPressed : null,
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
                      width: 145.0,
                      alignment: Alignment.center,
                      child: Obx(() => Text(
                        '오늘 가능한 탈고 횟수: ${_finishWritingPoem.remainingEdits.value}회',
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'KoPubBatangPro',
                          color: Color(0xFF373430),
                        ),
                        textAlign: TextAlign.center,
                      )),
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