import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/screens/my_page//my_designation.dart';
import 'package:to_morrow_front/ui/screens/my_page/my_profile_edit.dart';

// 계정 및 프로필 스크린
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E2DB),
        title: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back_ios_new),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            //const SizedBox(width: 1),
            const Text(
              '계정 및 프로필',
              style: TextStyle(
                  fontFamily: 'KoPubBatangPro', fontWeight: FontWeight.w700),
            ),
          ],
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Get.to(MyProfileEdit());
        //     },
        //     child: SvgPicture.asset(
        //       'assets/icons/mypage/setting_icon.svg',
        //     ),
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFBDBDBD),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0), // 여백을 적용할 부분
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // 자식 위젯들을 왼쪽으로 정렬합니다.
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center, // 아이콘을 원의 가운데에 배치합니다.
                        children: [
                          Container(
                            width: 80, // 동그라미의 크기
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD0CDC8), // 동그라미의 색상
                              shape: BoxShape.circle, // 동그라미 모양으로 설정
                            ),
                          ),
                          const Icon(
                            Icons.lock,
                            size: 32,
                            color: Color(0xFF6D675F),
                          ),
                          // 자물쇠 아이콘
                        ],
                      ),
                      const SizedBox(width: 16), // 아이콘과 텍스트 사이의 간격
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '투모로우 | 시인',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700), // 투모로우 | 시인 글씨 크기
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
                                    const SizedBox(width: 6), // 흰색이랑 350 잉크 사이 간격
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 4),
                                      // 텍스트와 박스 사이의 여백
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD0CDC8), // 박스의 배경색 설정
                                        borderRadius: BorderRadius.circular(
                                            4), // 모서리를 둥글게 만듦
                                      ),
                                      child: const Text(
                                        '350 잉크',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'KoPubBatangPro',
                                            fontWeight: FontWeight.w700),
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
                  const SizedBox(height: 24), // 프로필과 설명 텍스트 사이의 간격
                  const Text(
                    '별빛이 내린 언덕 않은 까닭입니다 별 하나에 추억과 말 한 마디씩 불러 봅니다 오면 무덤 위에 파란 잔디가 마디씩 불러 봅니다 소학교 때 차 있습니다',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 24), // 설명 텍스트와 버튼 사이의 간격
                  // 초대하기 버튼
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
                  const SizedBox(height: 24), // 초대하기 버튼과 선 사이의 간격
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width, // 디바이스의 전체 너비를 차지하도록 설정
              height: 1.0,
              color: const Color(0xFF373430), // 선 색상 설정
            ),
            //SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    '최애구독자',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        8,
                            (index) => const Column(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 32,
                              color: Color(0xFFD9D9D9),
                            ),
                            SizedBox(height: 10), // 여기에 10px 간격 추가
                            Text(
                              '횟수',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 24), // 구독자와 칭호 섹션 사이의 간격
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width, // 디바이스의 전체 너비를 차지하도록 설정
              height: 1.0,
              color: const Color(0xFF373430), // 선 색상 설정
            ),
            const SizedBox(height: 24),
            // 칭호 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // 좌우 여백 적용
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
                            SizedBox(width: 4), // 간격을 좁혀서 설정
                            Icon(
                              Icons.arrow_forward_ios, // > 모양의 아이콘 사용
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
              padding: const EdgeInsets.all(20.0), // 여백을 적용할 부분
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
      ),
    );
  }
}