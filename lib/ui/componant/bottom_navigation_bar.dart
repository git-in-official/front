import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../maintab_controller.dart';
import 'circle_button.dart';
import 'emotion_change_modal.dart';
import 'main_home_page.dart';

class Maintab extends StatelessWidget {
  final MainTabController tabController = Get.put(MainTabController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0xffE6E2DB),
        body: SafeArea(
          child: Column(
            children: [
              //배너 위치
              Container(height: 66, color: Colors.blueAccent),

              Expanded(
                child: IndexedStack(
                  index: 0,
                  children: [
                    HomePage(),
                    HomePage(),
                    HomePage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        //하단 탭
        bottomSheet: Obx(() {
          return tabController.showSecondBottomSheet.value
              ? _showBottomSheet(context)
              : SizedBox.shrink();
        }),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border:
                  Border(top: BorderSide(color: Color(0xffD0CDC8), width: 1.0)),
            ),
            child: BottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                //가운데 버튼
                if (index == 1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CircleMenuDialog(),
                  );
                }
                //메뉴버튼
                if (index == 2) {
                  tabController.showSecondBottomSheet.value =
                      !tabController.showSecondBottomSheet.value;
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/home.png',
                          width: 24, height: 24),
                      const Text(
                        '홈으로',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/home-ment.png',
                          width: 44, height: 44),
                    ],
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/menu.png',
                          width: 24, height: 24),
                      const Text(
                        '메뉴',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  label: '',
                ),
              ],
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedLabelStyle: null,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xffE6E2DB),
            )),
      ),
    );
  }

  Widget _showBottomSheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 132,
      decoration: const BoxDecoration(
        color: Color(0xFF373430),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            padding: EdgeInsets.fromLTRB(0, 12, 0, 20),
            decoration: BoxDecoration(
              color: const Color(0xFF373430),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: InkWell(
              onTap: () {
                tabController.showSecondBottomSheet.value = false;
              },
              child: Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E2DB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 84,
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPopupMenu('마이페이지', 'assets/images/mypage.png'),
                _buildPopupMenu('작업실', 'assets/images/study-lamp.png'),
                _buildPopupMenu('도서관', 'assets/images/library.png'),
                _buildPopupMenu('스토어', 'assets/images/store.png'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopupMenu(String label, String image) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 24,
            height: 24,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6D675F),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
