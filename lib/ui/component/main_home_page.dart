import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../filp/page_flip_widget.dart';

class HomePage extends StatelessWidget {
  final _pageFlipController = GlobalKey<PageFlipWidgetState>();

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
