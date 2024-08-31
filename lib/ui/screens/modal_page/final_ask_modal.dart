import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../repository/controller/audio_controller.dart';
import '../../../repository/controller/maintab_controller.dart';
import '../../../repository/controller/recording_controller.dart';
import '../../component/custom_text_button.dart';
import '../poem_loeading_page/poem_loading_page.dart';

class FinalAskModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final AudioController audioController = Get.put(AudioController());
    final AnimationControllerController animationControllerController =
    Get.put(AnimationControllerController());

    final RecordingController recordingController =
    Get.put(RecordingController());

    final MainTabController tabController = Get.find();


    return AlertDialog(
      backgroundColor: Color(0xffE6E2DB),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        width: 280,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFE6E2DB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, size: 24),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Text(
              '탈고 후에는 수정이 어렵습니다.\n낭독하신 원고를 제출하시겠습니까?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'KoPub Batang',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            CustomTextButton(text: '낭독 없이 탈고하겠습니다.',  height : 44, width: 203,onPressed: () {
              tabController.pageName.value = 'PoemLoadingPage';
              Navigator.of(context).pop();


            }),
            SizedBox(height: 15),
            CustomTextButton(text: '다시 낭독하겠습니다.', height : 44, width: 203,
              onPressed: () async {
                await audioController.deleteRecording(); // 녹음 파일 삭제
                animationControllerController.showStopIcon.value = false; // 녹음 아이콘 표시
                recordingController.isVisible.value = true; // 화면 표시
            }),
            SizedBox(height: 15),
            CustomTextButton(
              text: '낭독한 시를 탈고하겠습니다.',
              isHighlighted: true, height : 44, width: 203,
              onPressed: () {
                tabController.pageName.value = 'PoemLoadingPage';
                Navigator.of(context).pop();


              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
