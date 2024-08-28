import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:to_morrow_front/ui/screens/write_edit_page/write_edit_view.dart';

import '../../../repository/controller/maintab_controller.dart';
import '../../../repository/controller/topic_controller.dart';

class SoundWrite extends StatelessWidget {
  const SoundWrite({super.key});

  @override
  Widget build(BuildContext context) {
    final TopicController _controller = Get.put(TopicController('audio'));
    final MainTabController tabController = Get.find();

    // GetX 상태 관리
    final RxBool isPlaying = false.obs;
    final Rx<Duration> position = Duration.zero.obs;
    final Rx<Duration> duration = Duration.zero.obs;

    // AudioPlayer 인스턴스 생성
    final AudioPlayer player = AudioPlayer();

    void _setupAudioPlayer() {
      player.onPlayerStateChanged.listen((PlayerState state) {
        isPlaying.value = state == PlayerState.playing;
      });

      player.onPositionChanged.listen((Duration newPosition) {
        position.value = newPosition;
      });

      player.onDurationChanged.listen((Duration newDuration) {
        duration.value = newDuration;
      });
    }

    Future<void> _playPauseAudio() async {
      if (_controller.topic.value.isNotEmpty) {
        try {
          if (isPlaying.value) {
            await player.pause();
          } else {
            await player.play(UrlSource(_controller.topic.value));
            await player.resume();
          }
        } catch (e) {
          print('Error playing audio: $e');
        }
      } else {
        print('No audio URL provided');
      }
    }

    // 초기화
    _setupAudioPlayer();

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
                  '오늘의 소리글감을 알려드립니다.',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'KoPubBatangPro'),
                ),
                const SizedBox(height: 76.0),
                Container(
                  child: Image.asset('assets/img/sound_pic.png'),
                ),
                const SizedBox(height: 60.0),
               Obx(() {
                    return Column(
                      children: [
                        Slider(
                          value: position.value.inSeconds.toDouble(),
                          min: 0.0,
                          max: duration.value.inSeconds.toDouble(),
                          onChanged: (value) {
                            player.seek(Duration(seconds: value.toInt()));
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
                      color:  Color(0xFF373430),
                      border: Border.all(
                        color: Color(0xFFE6E2DB),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          isPlaying.value ? Icons.pause : Icons.play_arrow,
                          color: Color(0xFFE6E2DB),
                          size: 18.0,
                        ),
                        onPressed: () {
                          _playPauseAudio();
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 35.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
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
