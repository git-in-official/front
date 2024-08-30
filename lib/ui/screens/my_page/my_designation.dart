import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../repository/controller/user_controller.dart';
import 'my_achievement.dart'; // MyAchievement 페이지 import

class MyDesignation extends StatelessWidget {
  const MyDesignation({super.key});

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
      body: const MyRepresentativeBadge(),
    );
  }
}

class MyRepresentativeBadge extends StatefulWidget {
  const MyRepresentativeBadge({super.key});

  @override
  State<MyRepresentativeBadge> createState() => _MyRepresentativeBadgeState();
}

class _MyRepresentativeBadgeState extends State<MyRepresentativeBadge> {
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _userController.getMyProfileInfo();
    _userController.getMyAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        final profileData = _userController.profileData;
        final achievementList = _userController.achievementsList;
        String achievementName =
            profileData['mainAchievement']?['name'] ?? '-';
        String? badgeImagePath = profileData['mainAchievement']?['icon'];
        List<dynamic> achievements = achievementList.values.toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              '나의 대표 업적',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFD0CDC8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: badgeImagePath != null
                    ? SvgPicture.network(
                  badgeImagePath,
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
              achievementName,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 32),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1.0,
              color: const Color(0xFFBDBDBD),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: achievements != null && achievements.isNotEmpty
                  ? GridView.builder(
                padding: const EdgeInsets.all(40.0),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 32.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];

                  return GestureDetector(
                    onTap: () {
                      // 클릭 시 페이지 이동

                      Get.to(() => MyAchievement(achievementId: achievement['id'], achievementName: achievement['name'],selectedImgPath: achievement['icon'], description: achievement['description'],));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFF373430),
                        ),
                        Icon(
                          Icons.check, // 예시로 check 아이콘 사용
                          size: 32,
                          color: Colors.green, // 예시로 초록색 사용
                        ),
                        if (index == 0)
                          Positioned(
                            top: -10,
                            left: -10,
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(40.0),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 32.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: 9, // 자물쇠 아이콘 개수
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // 아이콘을 클릭해도 같은 페이지로 이동하도록 설정 가능
                      Get.to(() => MyAchievement(achievementId: '', achievementName: '', selectedImgPath: '', description: ''));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFFD0CDC8),
                        ),
                        const Icon(
                          Icons.lock,
                          size: 32,
                          color: Color(0xFF6D675F),
                        ),
                        if (index == 0)
                          Positioned(
                            top: -10,
                            left: -10,
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}