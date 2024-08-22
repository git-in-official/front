import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'custom_text_button.dart';
import 'final_ask_modal.dart';

class AnimationControllerController extends GetxController {
  var isAnimating = false.obs; // 애니메이션 상태 관리
  var showStopIcon = false.obs; // Stop 아이콘 표시 여부 관리
}

class RecordingController extends GetxController {
  var isVisible = true.obs; // 낭독 종료 후 저장 했을 때
}

class RecordingPage extends StatelessWidget {
  final String title;
  final String author;
  final String contents;

  RecordingPage({
    Key? key,
    required this.title,
    required this.author,
    required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnimationControllerController animationControllerController =
        Get.put(AnimationControllerController());

    final RecordingController recordingController =
        Get.put(RecordingController());

    final ScrollController _scrollController = ScrollController();

    final _scaleTween = Tween<double>(begin: 0.9, end: 1.0);
    final _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: TestVSync(),
    );

    final _animation = _scaleTween.animate(_animationController);

    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Color(0xffE6E2DB),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff373430),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '작가이름 $author',
                    style: TextStyle(fontSize: 14, color: Color(0xff6D675F)),
                  ),
                ),
                SizedBox(height: 40),
                Obx(() {
                  return Visibility(
                    visible: recordingController.isVisible.value,
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 28),
                          child: Text(
                            contents,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff373430),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    replacement: Container(
                      width: 320,
                      height: 224,
                      child:Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              Container(
                                decoration: BoxDecoration(color: Color(0xffEFEDEB)),
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                                child: Text(
                                  contents,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff373430),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            return Visibility(
                visible: recordingController.isVisible.value,
                child: Positioned(
                  right: 6,
                  bottom: 8,
                  child: GestureDetector(
                    onLongPress: () {
                      _animationController.forward();
                      animationControllerController.isAnimating.value = true;
                      animationControllerController.showStopIcon.value =
                          false; // 녹음 아이콘 표시
                    },
                    onLongPressUp: () {
                      _animationController.reverse();
                      animationControllerController.isAnimating.value = false;
                      animationControllerController.showStopIcon.value =
                          true; // Stop 아이콘 표시
                    },
                    onTap: () {
                      if (!animationControllerController.isAnimating.value &&
                          animationControllerController.showStopIcon.value) {
                        recordingController.isVisible.value = false; // 숨기기
                      }
                    },
                    child: ScaleTransition(
                      scale: _animation,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Image.asset(
                          animationControllerController.showStopIcon.value
                              ? 'assets/images/stop.png'
                              : 'assets/images/mic.png',
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                replacement: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(color: Colors.yellow, height: 36),
                        SizedBox(height: 22),
                        Container(
                          height: 92,
                          padding : EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                         child : Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextButton (text: '다시 낭독하기',onPressed: () {  },),
                              SizedBox(width: 8),
                              CustomTextButton (text: '탈고하기', isHighlighted : true, onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>  FinalAskModal(),
                                );
                              },)
                            ],
                          )

                        )
                      ]),
                ));
          }),
        ],
      ),
    );
  }
}

class TestVSync extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
