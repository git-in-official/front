import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/ui/screens/main_page/read_contents.dart';
import '../../../repository/controller/emotion_view_controller.dart';
import '../../../repository/controller/maintab_controller.dart';
import '../../../filp/page_flip_widget.dart';
import '../../component/speech_bubble.dart';

class HomePage extends StatelessWidget {
  final String emotion;
  final _pageFlipController = GlobalKey<PageFlipWidgetState>();
  final MainTabController tabController = Get.find();
  final EmotionViewController poemListController = Get.find();


  HomePage({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tabController.currentPage.value = 'Home';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      poemListController.getPoems(emotion);

    });

    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      body: SafeArea(
          child: Column(
              children: [
                // 상단 광고 배너 공간
                Container(
                  height: 66,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    'assets/images/banner.svg', // 이미지 파일 경로
                    fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록 설정
                  ),
                ),
                Expanded(
                  child: Obx(() {
                  if (poemListController.poems.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return PageFlipWidget(
                      key: _pageFlipController,
                      backgroundColor: Color(0xffE6E2DB),
                      isRightSwipe: false,
                      children: <Widget>[
                        for (int index = 0; index < poemListController.poems.length; index++)
                          ReadWritingPage(
                            title: poemListController.poems[index].title,
                            author: poemListController.poems[index].authorName,
                            contents: poemListController.poems[index].content,
                            isScrapped: poemListController.poems[index].isScrapped.obs,
                            textAlign: poemListController.poems[index].textAlign,
                            textSize: poemListController.poems[index].textSize.toDouble(),
                            textFont: poemListController.poems[index].textFont,
                            audioUrl: poemListController.poems[index].audioUrl,
                            id: poemListController.poems[index].id,
                            putAnimationWidget: index % 3 == 0,
                          ),
                      ],
                    );
                  }
                }),),

              ])
      ),
    );
  }
}
