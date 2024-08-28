import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../repository/controller/user_controller.dart';
import '../../component/alert_dialog.dart';

class _MyAchievementState extends State<MyAchievement> {
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _userController.getMyProfileInfo();
    _userController.getMyAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E2DB),
        titleSpacing: 16,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '업적',
              style: TextStyle(
                fontFamily: 'KoPubBatangPro',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFBDBDBD),
            height: 1.0,
          ),
        ),
      ),
      body: Obx(() {
        final mainAchievementId = _userController.profileData['mainAchievement']?['id'];
        final isMainAchievement = mainAchievementId == widget.achievementId;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 124.0),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFD0CDC8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: widget.selectedImgPath.isNotEmpty
                      ? SvgPicture.network(
                    widget.selectedImgPath,
                    width: 32.0,
                    height: 32.0,
                  )
                      : const Icon(
                    Icons.lock,
                    size: 32,
                    color: Color(0xFF6D675F),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                widget.achievementName,
                style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.description.isNotEmpty
                    ? '이 칭호를 얻으려면 ${widget.description} 를 하세요.'
                    : '업적을 먼저 달성하세요!',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isMainAchievement
                      ? () {
                    // 버튼을 누를 때 알럿 창 표시
                    AlertDialogClass.showAlert(
                      context: context,
                      message: '두 편의 시를 풀어주셨네요.\n다른 이들의 시를 감상해보세요.',
                      onConfirm: () {
                        // 확인 버튼 클릭 시 실행할 작업
                        print('확인 버튼 클릭됨');
                        _userController.putMainAchievement(widget.achievementId);
                      },
                    );
                  }
                      : null, // 비활성화 상태일 때 null로 설정
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF373430),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '대표 업적으로 변경하기',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class MyAchievement extends StatefulWidget {
  final String achievementId;
  final String achievementName;
  final String selectedImgPath;
  final String description;

  MyAchievement({
    required this.achievementId,
    required this.achievementName,
    required this.selectedImgPath,
    required this.description,
  });

  @override
  _MyAchievementState createState() => _MyAchievementState();
}
