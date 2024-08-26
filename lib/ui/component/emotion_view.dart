import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/screens/write_edit_page//write_edit_view.dart';
import 'package:to_morrow_front/ui/view_model/emotion_view_model.dart';


class EmotionView extends GetView<EmotionViewModel> {

  const EmotionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmotionViewModel>(); // EmotionViewModel 인스턴스 찾기

    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                '작가님의 기분에 맞춰\n시를 보여드리고 싶어요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'KoPubBatangPro',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.34,
                  ),
                  itemCount: controller.emotions.length,
                  itemBuilder: (context, index) {
                    final emotion = controller.emotions[index];
                    return Obx(() {
                      final isSelected = controller.selectedEmotion.value == emotion;
                      return GestureDetector(
                        onTap: () => controller.selectEmotion(emotion),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF373430) : const Color(0xFFE6E2DB),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: const Color(0xFF3B3731),
                              width: 1.0,
                            ),
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(-2, -2),
                                blurRadius: 5.0,
                              ),
                            ]
                                : [],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 이모티콘
                                Image.asset(
                                  emotion.iconPath,
                                  height: 24,
                                  color: isSelected ? const Color(0xFFE6E2DB) : const Color(0xFF373430),
                                ),
                                const SizedBox(height: 16.0),
                                // title 글자
                                Text(
                                  emotion.title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'KoPubBatangPro',
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? const Color(0xFFE6E2DB) : const Color(0xFF373430),
                                  ),
                                ),
                                // detail 글자
                                Text(
                                  emotion.detail.join(', '),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'KoPubBatangPro',
                                    fontWeight: FontWeight.w400,
                                    color: isSelected ? const Color(0xFFE6E2DB) : const Color(0xFF373430),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              Obx(() {
                final isButton = controller.selectedEmotion.value != null;
                return GestureDetector(
                  onTap: isButton
                      ? () {
                    // 다음 페이지 이동
                    Get.to(() => '');
                  }
                      : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 24.0),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: isButton
                          ? const Color(0xFF373430)
                          : const Color(0xFF373430).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '입력 완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'KoPubBatangPro',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}