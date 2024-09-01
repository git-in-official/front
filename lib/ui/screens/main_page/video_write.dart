import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../repository/controller/maintab_controller.dart';
import '../../../repository/controller/topic_controller.dart';
import '../write_edit_page/write_edit_view.dart';

class VideoWrite extends StatelessWidget {
  final TopicController _controller = Get.put(TopicController('video'));
  final MainTabController tabController = Get.find();

  late final VideoPlayerController videoController;
  final RxBool isPlaying = false.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;

  VideoWrite() {
    _initializeVideoPlayer();
  }

  final RxBool videoInitialized = false.obs;

  //비디오 초기화
  void _initializeVideoPlayer() {
    final uri = Uri.parse(_controller.topic.value);
    videoController = VideoPlayerController.networkUrl(uri)
      ..initialize().then((_) {
        videoInitialized.value = true; // 초기화 완료
        duration.value = videoController.value.duration; // 비디오 길이 저장
        videoController.addListener(() {
          position.value = videoController.value.position; // 현재 위치 업데이트
        });
      }).catchError((error) {
        print("비디오 초기화 오류: $error");
      });
  }

  // 비디오 재생/일시정지
  void _playPauseVideo() {
    if (videoController.value.isInitialized) {
      if (videoController.value.isPlaying) {
        videoController.pause();
        isPlaying.value = false;
      } else {
        videoController.play();
        isPlaying.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    tabController.currentPage.value = 'VideoWrite';

    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/main_menu/main_menu_icon.svg',
                  width: 64.0,
                  height: 64.0,
                ),
                const SizedBox(height: 24.0),
                const Text(
                  '오늘의 영상글감을 알려드립니다.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'KoPubBatangPro',
                  ),
                ),
                const SizedBox(height: 24.0),

                // 비디오 플레이어
                Obx(() {
                  if (videoInitialized.value && videoController.value.isInitialized) {
                    return Container(
                      height: 168,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 168,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFF373430),
                      ),
                    );
                  }
                }),

                const SizedBox(height: 8.0),

                Obx(() {
                  return Column(
                    children: [
                      Slider(
                        value: position.value.inSeconds.toDouble(),
                        min: 0.0,
                        max: duration.value.inSeconds.toDouble(),
                        onChanged: (value) {
                          videoController.seekTo(Duration(seconds: value.toInt()));
                          position.value = Duration(seconds: value.toInt());
                        },
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 10.0),
                Obx(() {
                  return Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF373430),
                      border: Border.all(
                        color: const Color(0xFFE6E2DB),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          isPlaying.value ? Icons.pause : Icons.play_arrow,
                          color: const Color(0xFFE6E2DB),
                          size: 18.0,
                        ),
                        onPressed: _playPauseVideo,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 35.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.type.value = 'video';
                      tabController.pageName.value = 'WriteEdit';
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF373430),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      '글쓰기',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'KoPubBatangPro',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
