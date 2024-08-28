import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/screens/my_page/my_designation.dart';
import '../../../repository/controller/user_controller.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final UserController _userController = Get.put(UserController()); // UserController를 인스턴스화하고, GetX로 관리

  @override
  void initState() {
    super.initState();
    _userController.getMyProfileInfo(); // 초기화 시 프로필 정보 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E2DB),
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 1),
            const Text(
              '계정 및 프로필',
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
        // 프로필 데이터를 바인딩할 때 Obx 사용
        if (_userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // 로딩 중일 때 로딩 인디케이터 표시
        }

        if (_userController.profileData.isEmpty) {
          return const Center(child: Text('프로필 정보를 불러오지 못했습니다.')); // 데이터가 없을 때 메시지 표시
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD0CDC8),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Icon(
                              Icons.lock,
                              size: 32,
                              color: Color(0xFF6D675F),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userController.profileData['name'] ?? '이름 없음', // 프로필 이름을 표시
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD0CDC8),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/main_menu/ink_icon.svg',
                                        width: 24.0,
                                        height: 24.0,
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD0CDC8),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${_userController.profileData['points'] ?? 0} 잉크', // 프로필 포인트를 표시
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'KoPubBatangPro',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _userController.profileData['description'] ?? '프로필 설명 없음', // 프로필 설명을 표시
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),
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
                          '초대하기',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1.0,
                color: const Color(0xFF373430),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '최애구독자',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(8, (index) {
                        return Column(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 32,
                              color: const Color(0xFFD9D9D9),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '횟수',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1.0,
                color: const Color(0xFF373430),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '업적',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(MyDesignation());
                          },
                          child: const Row(
                            children: [
                              Text(
                                '모두보기',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF6D675F),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    return const Column(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 32,
                          color: Color(0xFFD9D9D9),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '시인',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}