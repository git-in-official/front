import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/auth_service.dart';
import 'package:to_morrow_front/repository/controller/finish_writing_poem.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';

import '../../component/bottom_navigation_bar.dart';

class PoemLoadingPage extends StatelessWidget {
  final FinishWritingPoem _finishWritingPoem = Get.put(FinishWritingPoem());
  final WriteEditViewModel writeEditViewModel = Get.find();
  final MainTabController tabController = Get.find();

  void _onConfirmPressed() {
    Get.offAll(() => Maintab());
    tabController.pageName.value = "Home";
  }

  @override
  Widget build(BuildContext context) {
    _startSendingPoemData();
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
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
                    '${writeEditViewModel.userName.value}님의 작품이 \n'
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
                          _getStageText(_finishWritingPoem.stage.value),
                          key: ValueKey<int>(_finishWritingPoem.stage.value),
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _finishWritingPoem.isSendingComplete.value
                          ? _onConfirmPressed
                          : null,
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
                ],
              ),
              // 멘트
              Positioned(
                bottom: 170,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
        ),
      ),
    );
  }

  String _getStageText(int stage) {
    switch (stage) {
      case 0:
        return '교';
      case 1:
        return '교정';
      case 2:
        return '교정중';
      default:
        return '';
    }
  }

  void _startSendingPoemData() {
    _finishWritingPoem.donePoem();
  }
}
