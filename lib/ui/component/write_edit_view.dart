import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';

class WriteEditView extends StatelessWidget {
  final WriteEditViewModel viewModel = Get.put(WriteEditViewModel());
  WriteEditView({super.key});

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
                        // 텍스트 정렬 변경
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
                                bottomLeft: Radius.circular(16),
                              ),
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
                        // 폰트 크기 변경
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
                                bottomLeft: Radius.circular(16),
                              ),
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
                        // 글꼴 변경
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
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/img/brand_family.png',
                                width: 24,
                              ),
                              onPressed: () {
                                // 글꼴 변경 모달창 열기
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
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: '제목을 입력해주세요',
                                        hintStyle: TextStyle(color: Color(0xFFB8B4AD)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFB8B4AD)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF373430)),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'KoPubBatangPro',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      // 텍스트 정렬 적용
                                      textAlign: _getTextAlign(viewModel.textAlign.value),
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
                                    TextField(
                                      decoration: const InputDecoration(
                                        hintText: '본문을 입력해주세요',
                                        hintStyle: TextStyle(color: Color(0xFFB8B4AD)),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        // 폰트 크기 적용
                                        fontSize: 14.0,
                                        fontFamily: 'KoPubBatangPro',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      // 텍스트 정렬 적용
                                      textAlign: _getTextAlign(viewModel.textAlign.value),
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
                          );
                        }),
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

  // 텍스트 정렬 변경
  TextAlign _getTextAlign(int value) {
    switch (value) {
      case 1:
        return TextAlign.center;
      case 2:
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }
}