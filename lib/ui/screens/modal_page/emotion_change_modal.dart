import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/controller/emotion_view_controller.dart';
import '../../../repository/controller/maintab_controller.dart';
import '../../component/bottom_navigation_bar.dart';

class EmotionChangeModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainTabController tabController = Get.find();

    // 모달에서 임시로 선택된 기분 추적
    RxInt tempSelectedIndex = (-1).obs;

    // 모달이 열릴 때 현재 선택된 기분을 임시로 저장
    tempSelectedIndex.value = tabController.selectedEmotionIndex.value;

    return Obx(() {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Container(
          width: 280,
          height: 410,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xFFE6E2DB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                height: 56,
                padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, size: 24),
                      onPressed: () {
                        //기존 선택 유지하면서 모달 닫기
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const Text(
                '작가님의 기분에 맞춰\n시를 보여드리고 싶어요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'KoPubBatangPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 7,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.6,
                  ),
                  padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                  itemBuilder: (context, index) {
                    final imagePaths = [
                      'assets/images/icon-happy.png',
                      'assets/images/icon-sad.png',
                      'assets/images/icon-fear.png',
                      'assets/images/icon-anger.png',
                      'assets/images/icon-expect.png',
                      'assets/images/icon-trust.png',
                      'assets/images/icon-dontno.png',
                    ];
                    final labels = [
                      '기쁨',
                      '슬픔',
                      '두려움',
                      '분노',
                      '기대',
                      '신뢰',
                      '모르겠음'
                    ];

                    return EmotionButton(
                      imagePath: imagePaths[index],
                      label: labels[index],
                      isSelected: tempSelectedIndex.value == index,
                      onSelect: () {
                        // 기분을 선택할 때 임시값을 업데이트
                        tempSelectedIndex.value = index;
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                child: ElevatedButton(
                  onPressed: tempSelectedIndex.value !=
                          tabController.selectedEmotionIndex.value
                      ? () {
                          // 확인 버튼 클릭 시 선택된 기분 저장
                          final selectedEmotion = [
                            '기쁨',
                            '슬픔',
                            '두려움',
                            '분노',
                            '기대',
                            '신뢰',
                            '모르겠음'
                          ][tempSelectedIndex.value];
                          tabController.selectedEmotionIndex.value =
                              tempSelectedIndex.value;
                          tabController.selectedEmotion.value = selectedEmotion;

                          final EmotionViewController emotionViewController = Get.find();
                          emotionViewController.sendEmotionToServer(tabController.selectedEmotion.value);

                          Get.to(() => Maintab());

                          //모달창 닫고
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFE3DED4),
                    backgroundColor: tempSelectedIndex.value !=
                            tabController.selectedEmotionIndex.value
                        ? Color(0xFF3B3731)
                        : Color(0xFFBDBDBD),
                    minimumSize: Size(240, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class EmotionButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  EmotionButton({
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelect,
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF373430),
        backgroundColor: isSelected ? Color(0xFF373430) : Color(0xFFE6E2DB),
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(color: Color(0xFF373430)),
        elevation: 0,
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
            color: isSelected ? Color(0xffE6E2DB) : Color(0xFF373430),
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Color(0xffE6E2DB) : Color(0xFF373430),
            ),
          ),
        ],
      ),
    );
  }
}
