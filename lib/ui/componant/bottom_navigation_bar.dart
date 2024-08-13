import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'circle_button.dart';
import 'fakepage.dart';

class Maintab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            await _onBackPressed(context);
            return false;
          },
          child: SafeArea(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FakePage(),
                FakePage(),
                FakePage(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: 60,
            width: deviceWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xffE6E2DB),
              ),
              child: TabBar(
                onTap: (index) {
                  if (index == 1) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CircleMenuDialog(),
                    );
                  }
                },
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.store, size: 20),
                        SizedBox(width: 8),
                        Text('스토어'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Image.asset('assets/images/home-ment.png', width: 44, height: 44),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.anchor_sharp, size: 20),
                        SizedBox(width: 8),
                        Text('글쓰기'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> _onBackPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('종료 하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            child: const Text('아니요'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('네'),
            onPressed: () {
              Navigator.pop(context);
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
