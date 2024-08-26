import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/screens/main_page/read_contents.dart';

import '../../../data/model/config/emotion_writing.dart';
import '../../../filp/page_flip_widget.dart';
import '../../../repository/controller/maintab_controller.dart';

class HomePage extends StatelessWidget {
  final String emotion;
  final _pageFlipController = GlobalKey<PageFlipWidgetState>();
  final MainTabController tabController = Get.find();

  HomePage({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> emotionData;

    switch (tabController.selectedEmotion.value) {
      case '기쁨':
        emotionData = happy;
        break;
      case '기대':
        emotionData = expectation;
        break;
      case '두려움':
        emotionData = afraid;
        break;
      case '분노':
        emotionData = anger;
        break;
      case '슬픔':
        emotionData = sad;
        break;
      case '안정':
        emotionData = trust;
        break;
      default:
        emotionData = expectation;
    }

    return Scaffold(
        backgroundColor: Color(0xffE6E2DB),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 66,
                color: Colors.blueAccent,
              ),
              Expanded(
                child: PageFlipWidget(
                  key: _pageFlipController,
                  backgroundColor: Color(0xffE6E2DB),
                  isRightSwipe: false,
                  children: <Widget>[
                    for (var i = 0; i < emotionData.length; i++)
                      ReadWritingPage(
                        title: emotionData[i]['title'] ?? '제목 없음',
                        author: emotionData[i]['author'] ?? '알 수 없음',
                        contents: emotionData[i]['contents'] ?? '내용 없음',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
