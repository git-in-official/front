import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/screens/my_page/my_designation.dart';
import '../../../repository/controller/user_controller.dart';
import '../../component/emotion_view.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final UserController _userController = Get.put(
      UserController()); // UserController를 인스턴스화하고, GetX로 관리

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // 뒤로가기 아이콘 추가 및 색상 설정
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 기능
          },
        ),
        title: const Row(
          children: [
            SizedBox(width: 1),
            Text(
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
          return const Center(
            child: CircularProgressIndicator(),
          ); // 로딩 중일 때 로딩 인디케이터 표시
        }

        if (_userController.profileData.isEmpty) {
          return const Center(
            child: Text('프로필 정보를 불러오지 못했습니다.'),
          ); // 데이터가 없을 때 메시지 표시
        }

        String? iconUrl = _userController
            .profileData['mainAchievement']?['icon'];

        List? scrapUsers = _userController.profileData['scrapUsers']; // 최애구독자 정보 목록
        List? achievements = _userController.profileData['achievements']; // 나의 업적달성 목록

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
                            Center(
                              child: iconUrl != null
                                  ? SvgPicture.network(
                                iconUrl,
                                width: 32.0,
                                height: 32.0,
                              )
                                  : const Icon(
                                Icons.lock,
                                size: 32,
                                color: Color(0xFF6D675F),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_userController.profileData['name'] ??
                                  '-'} | ${_userController
                                  .profileData['mainAchievement']?['name'] ??
                                  '-'}' ??
                                  '이름 없음', // 프로필 이름을 표시
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD0CDC8),
                                          borderRadius: BorderRadius.circular(
                                              4),
                                        ),
                                        child: Text(
                                          '${_userController
                                              .profileData['points'] ?? 0} 잉크',
                                          // 프로필 포인트를 표시
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
                      _userController.profileData['introduction'] ??
                          '프로필 설명 없음', // 프로필 설명을 표시
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                content: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                          icon:
                                          const Icon(Icons.close, size: 24),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      // 텍스트 메시지
                                      const Flexible(
                                        child: Text(
                                          '기능 구현 준비중입니다. ^^;',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'KoPubBatangPro',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Color(0xFF373430),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: scrapUsers != null && scrapUsers.isNotEmpty
                            ? scrapUsers.map<Widget>((scrapUser) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0), // 양쪽 간격 8px
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 32,
                                  color: Color(0xFFD9D9D9),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${scrapUser['count'] ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()
                            : [ // 빈 리스트일 경우에도 List<Widget>을 반환하도록 설정
                          const Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              '아직은 최애구독자가 없습니다. 최애구독자를 만들어보세요!',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: achievements != null && achievements.isNotEmpty
                      ? achievements.map<Widget>((achievement) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0), // 양쪽 간격 8px
                      child:  Container(
                        width: 74.0, // width를 74px로 설정
                        height: 74.0, // height를 74px로 설정
                        padding: const EdgeInsets.all(8.0), // 패딩 값을 8px로 줄임
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16), // borderRadius 16px 적용
                          border: Border.all(
                            color: const Color(0xFF6D675F), // 테두리 색상 지정
                            width: 1.0, // 테두리 두께
                          ),
                        ),
                        child: Container(
                          width: 74.0, // width를 74px로 설정
                          height: 74.0, // height를 74px로 설정
                          padding: const EdgeInsets.all(8.0), // 패딩 값을 8px로 줄임
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16), // borderRadius 16px 적용
                            border: Border.all(
                              color: const Color(0xFF6D675F), // 테두리 색상 지정
                              width: 1.0, // 테두리 두께
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Column 내용을 수직 가운데 정렬
                            children: [
                              Icon(
                                Icons.circle,
                                size: 32,
                                color: Color(0xFFD9D9D9),
                              ),
                              SizedBox(height: 4), // SizedBox 높이를 줄임
                              Text(
                                '업적',
                                style: TextStyle(
                                  fontSize: 12, // 글꼴 크기 줄임
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList()
                      : [ // 빈 리스트일 경우에도 List<Widget>을 반환하도록 설정
                    const Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        '아직은 아쉽지만 업적이 없습니다. 업적을 달성해보세요!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}