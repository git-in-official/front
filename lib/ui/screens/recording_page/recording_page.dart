import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../repository/controller/audio_controller.dart';
import '../../../repository/controller/recording_controller.dart';
import '../../component/custom_text_button.dart';
import '../modal_page/final_ask_modal.dart';



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

    final AudioController audioController = Get.put(AudioController());

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
                    '$author',
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
                      child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              Container(
                                decoration: BoxDecoration(color: const Color(0xFFE6E2DB)),
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
                  // 길게 눌렀을 때
                  onLongPress: () async {
                    // 녹음 시작
                    await audioController.record();

                    _animationController.forward();
                    animationControllerController.isAnimating.value = true;
                    animationControllerController.showStopIcon.value = false; // 녹음 아이콘 표시
                  },

                  // 길게 누르던 걸 떼었을 때
                  onLongPressUp: () async {
                    await audioController.stop();

                    _animationController.reverse();
                    animationControllerController.isAnimating.value = false;
                    animationControllerController.showStopIcon.value = true; // Stop 아이콘 표시
                  },

                  // 정지 아이콘을 한번 탭 했을 때
                  onTap: () async {
                    // 로컬에 저장
                    await audioController.saveRecordingLocally();

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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          // 재생 버튼 + 일시 중지 버튼
                          Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE6E2DB),
                              border: Border.all(
                                color: Color(0xFF373430),
                                width: 1.0, // Border width
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  audioController.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Color(0xFF373430),
                                  size: 18.0, // Icon size
                                ),
                                onPressed: () async {
                                  if (audioController.isPlaying.value) {
                                    await audioController.audioPlayer.pause();
                                    audioController.isPlaying.value = false;
                                  } else {
                                    await audioController.playAudio();
                                    await audioController.audioPlayer.resume();
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // 재생 바
                          Expanded(child: Obx(() {
                            return Slider(
                              min: 0,
                              max: audioController.duration.value.inSeconds.toDouble(),
                              value: audioController.position.value.inSeconds.toDouble(),
                              inactiveColor: Colors.grey,
                              activeColor: Color(0xff373430),
                              onChanged: (value) async {
                                audioController.position.value = Duration(seconds: value.toInt());
                                await audioController.audioPlayer.seek(audioController.position.value);
                              },
                            );
                          })),
                          SizedBox(width: 15),
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    Container(
                      height: 92,
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextButton(
                            text: '다시 낭독하기',
                            onPressed: () async {
                              await audioController.deleteRecording(); // 녹음 파일 삭제
                              animationControllerController.showStopIcon.value = false; // 녹음 아이콘 표시
                              recordingController.isVisible.value = true; // 화면 표시
                            },
                          ),
                          SizedBox(width: 8),
                          CustomTextButton(
                            text: '탈고하기',
                            isHighlighted: true,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => FinalAskModal(),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
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
