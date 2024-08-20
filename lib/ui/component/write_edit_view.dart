import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';

class WriteEditView extends StatelessWidget {
  final WriteEditViewModel viewModel = Get.put(WriteEditViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 상단 광고 배너 공간
            Container(
              height: 66,
              color: Colors.grey,
              width: double.infinity,
              child: const Center(child: Text("광고")),
            ),
            Expanded(
              child: Row(
                children: [
                  // 왼쪽 사이드바
                  Container(
                    width: 50,
                    color: const Color(0xFF6D675F),
                    child: Stack(
                      children: [
                        // 텍스트 정렬
                        Positioned(
                          top: 42,
                          left: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE6E2DB),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(16)),
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/img/format_align_left.png',
                                width: 24,
                              ),
                              onPressed: viewModel.toggleTextAlign,
                            ),
                          ),
                        ),
                        // 폰트 크기
                        Positioned(
                          top: 88,
                          left: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE6E2DB),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(16)),
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/img/format_size.png',
                                width: 24,
                              ),
                              onPressed: viewModel.toggleFontSize,
                            ),
                          ),
                        ),
                        // 폰트 변경
                        Positioned(
                          top: 134,
                          left: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE6E2DB),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(16)),
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/img/brand_family.png',
                                width: 24,
                              ),
                              onPressed: () {
                                // 글꼴 선택 모달 창 열기
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 오른쪽 입력 부분
                  Expanded(
                    child: Container(
                      color: const Color(0xFFE6E2DB),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 24),
                            const Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: '제목을 입력해주세요',
                                      hintStyle:
                                      TextStyle(color: Color(0xFFB8B4AD)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFB8B4AD)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF373430)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 46,
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    '투모로우',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'KoPubBatangPro',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF373430),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  const TextField(
                                    decoration: InputDecoration(
                                      hintText: '본문을 입력해주세요',
                                      hintStyle: TextStyle(color: Color(0xFFB8B4AD)),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 1,
                                      color: const Color(0xFFB8B4AD),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}