import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_morrow_front/ui/screens/write_edit_page/write_edit_view.dart';

import '../../../repository/controller/maintab_controller.dart';
import '../../../repository/controller/topic_controller.dart';

class VideoWrite extends StatelessWidget {
  const VideoWrite({super.key});

  @override
  Widget build(BuildContext context) {
    final TopicController _controller = Get.put(TopicController('video'));
    print(_controller.topic.value);
    final MainTabController tabController = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 80.0,),
                SvgPicture.asset(
                  'assets/icons/main_menu/main_menu_icon.svg',
                  width: 64.0,
                  height: 64.0,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  '오늘의 영상글감을 알려드립니다.',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'KoPubBatangPro'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  child: Image.asset('assets/img/video_demo_pic.png'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Image.asset(
                  'assets/img/media_bar.png',
                  width: 280.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SvgPicture.asset(
                  'assets/icons/main_menu/play_icon.svg',
                  height: 48.0,
                  width: 48.0,
                ),
                const SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      tabController.pageName.value = 'WriteEdit';
                      Get.to(() => WriteEditView(source: 'video'));
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
