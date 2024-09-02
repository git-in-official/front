import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../repository/controller/emotion_analysis_controller.dart';
import '../../../repository/controller/tag_edit_controller.dart';
import '../sentiment_analysis_page/user_sentiment_tag_page.dart';

class WaitingInfoModal extends StatefulWidget {
  final String title;
  final List<String> apiTags;

  WaitingInfoModal(this.title, this.apiTags);

  @override
  _WaitingInfoModalState createState() => _WaitingInfoModalState();
}

class _WaitingInfoModalState extends State<WaitingInfoModal> {
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _performAsyncTask();
  }

  Future<void> _performAsyncTask() async {
    final TagEditController tagEdit = Get.put(TagEditController());
    await tagEdit.changeTags(widget.title, widget.apiTags);

    final UserSentimentTagPageController userSentimentTagController = Get.find();
    userSentimentTagController.wantGobak.value = true;
    Get.find<EmotionAnalysisController>().update();

    setState(() {
      _isProcessing = false;
    });

    // 모달창 닫아
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            width: 280,
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFE6E2DB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/main_menu/main_menu_icon.svg',
                  width: 48.0,
                  height: 48.0,
                ),
                SizedBox(height: 24.0),
                const Text(
                  '테마를 변경 중 입니다. \n 잠시만 기다려주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'KoPubBatangPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isProcessing)
          //화면 아무것도 못하게 막기
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacity(0.0),
          ),
      ],
    );
  }
}
