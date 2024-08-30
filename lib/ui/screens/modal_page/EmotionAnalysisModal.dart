import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';
import 'package:to_morrow_front/ui/component/custom_text_button.dart';
import 'package:to_morrow_front/ui/screens/write_edit_page/emotion_analysis_loading.dart';

class EmotionAnalysisModal extends StatelessWidget {
  EmotionAnalysisModal({super.key});
  final MainTabController tabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        //보더레디우스 24
        borderRadius: BorderRadius.circular(24.0),
      ),
      content: Container(
        width: 280,
        height: 267,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E2DB),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Column(
          children: [
            // 닫기 버튼
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, size: 24),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            //const SizedBox(height: 8.0),
            // 텍스트 메시지
            const Text(
              '집필하신 작품을 탈고하기 전에\n감정분석을 시작합니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'KoPubBatangPro',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF373430),
              ),
            ),
            const SizedBox(height: 20),
            // 버튼들
            Column(
              children: [
                CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: '이전으로',
                  isHighlighted: false,
                ),
                const SizedBox(height: 15),
                CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    tabController.pageName.value = 'EmotionAnalysisLoading';
                  },
                  text: '감정분석하기',
                  isHighlighted: true,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
