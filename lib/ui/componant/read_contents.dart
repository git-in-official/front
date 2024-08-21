import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../maintab_controller.dart';
import 'emotion_change_modal.dart';

class ReadWritingPage extends StatelessWidget {

  final MainTabController tabController = Get.put(MainTabController());


  final String title;
  final String author;
  final String contents;

   ReadWritingPage({
    Key? key,
    required this.title,
    required this.author,
    required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE6E2DB),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildEmotionSelector(context),
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
              '작가이름 ${author}',
              style: TextStyle(fontSize: 14, color: Color(0xff6D675F)),
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
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
          // Container(
          //   height: 84,
          //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 24),
          //   child: Row(
          //     children: [
          //       Image.asset("assets/images/button_play.png", width: 36,height: 36)
          //     ],
          //   )
          // )
        ],
      ),
    );
  }

  Widget _buildEmotionSelector(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => EmotionChangeModal(),
        );
      },
      child: Obx(() {
        final imagePaths = [
          'assets/images/icon-happy.png',
          'assets/images/icon-sad.png',
          'assets/images/icon-fear.png',
          'assets/images/icon-anger.png',
          'assets/images/icon-expect.png',
          'assets/images/icon-trust.png',
          'assets/images/icon-dontno.png',
        ];
        final selectedIndex = tabController.selectedEmotionIndex.value;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              Image.asset(
                selectedIndex >= 0
                    ? imagePaths[selectedIndex]
                    : 'assets/images/icon-happy.png',
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text('감정선택', style: TextStyle(fontSize: 14)),
            ],
          ),
        );
      }),
    );
  }

}
