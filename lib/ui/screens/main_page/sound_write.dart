import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../repository/controller/maintab_controller.dart';
import '../../../repository/controller/sound_write_controller.dart';
import '../../../repository/controller/topic_controller.dart';

class SoundWrite extends StatelessWidget {

   @override
  Widget build(BuildContext context) {

     // Get.delete<TopicController>(force: true);
     final TopicController _controller = Get.put(TopicController('audio'));


    final MainTabController tabController = Get.find();
    final SoundWriteController audioController = Get.find();

     tabController.currentPage.value = 'SoundWrite';

     Future<void> playPauseAudio() async {
      if (_controller.topic.value.isNotEmpty) {
        try {
          if (audioController.isPlaying.value) {
            await audioController.player.pause();
          } else {
            await audioController.player.play(UrlSource(_controller.topic.value));
            await audioController.player.resume();
          }
        } catch (e) {
          print('Error playing audio: $e');
        }
      } else {
        print('No audio URL provided');
      }
    }

    // 초기화
    audioController.setupAudioPlayer();

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
                  child: SvgPicture.asset('assets/img/sound_pic.svg'),
                ),
                const SizedBox(height: 60.0),
                Obx(() {
                  return Column(
                    children: [
                      Slider(
                        value: audioController.position.value.inSeconds.toDouble(),
                        min: 0.0,
                        max: audioController.duration.value.inSeconds.toDouble(),
                        onChanged: (value) {
                          audioController.player.seek(Duration(seconds: value.toInt()));
                          audioController.position.value = Duration(seconds: value.toInt());
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
                      color: Color(0xFF373430),
                      border: Border.all(
                        color: Color(0xFFE6E2DB),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          audioController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                          color: Color(0xFFE6E2DB),
                          size: 18.0,
                        ),
                        onPressed: () {
                          playPauseAudio();
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
                      _controller.type.value = 'audio';
                      audioController.stopAudio();
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
