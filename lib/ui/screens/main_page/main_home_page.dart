import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_morrow_front/ui/screens/main_page/read_contents.dart';

import '../../../filp/page_flip_widget.dart';
import '../../../repository/maintab_controller.dart';


class HomePage extends StatelessWidget {

  final _pageFlipController = GlobalKey<PageFlipWidgetState>();
  final MainTabController tabController = Get.put(MainTabController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      body: PageFlipWidget(
        key: _pageFlipController,
        backgroundColor: Color(0xffE6E2DB),
        isRightSwipe: false,
        lastPage: Container(
          color: Color(0xffE6E2DB),
          child: const Center(child: Text('Last Page!')),
        ),
        ///Todo) 통신해서 감정에 맞는 글 가져오기 -> 리스트로 뿌려

        children: <Widget>[

          for (var i = 0; i < 10; i++)
            ReadWritingPage(
              title: '니가 어떤 딸인데 그러니',
              author: 'user${i + 1}',
              contents:
                  '너 훌쩍이는 소리가\n네 어머니 귀에는 천둥소리라 하더라.\n그녀를 닮은 얼굴로 서럽게 울지마라.',
            ),
        ],
      ),
    );
  }


}
