import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/emotion_view_controller.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';
import 'package:to_morrow_front/ui/screens/modal_page/EmotionAnalysisModal.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';
import '../../data/model/config/page_route.dart';
import '../../repository/controller/circle_button_controller.dart';
import '../../repository/controller/sound_write_controller.dart';
import '../screens/modal_page/Inspiration_done_modal.dart';
import 'circle_button.dart';

class Maintab extends StatelessWidget {
  final MainTabController tabController = Get.find();
  final EmotionViewController controller = Get.find();
  final SoundWriteController audioController = Get.find();

  final CircleButtonController _controller =
  Get.put(CircleButtonController());

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: tabController.onWillPop,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,
          ),
        ),
        child: Obx(() {
          Widget currentPage = pages[tabController.pageName.value]?.call(tabController.selectedEmotion.value) ?? Container();

          return Scaffold(
            backgroundColor: Color(0xffE6E2DB),
            body: IndexedStack(
              index: tabController.rootPageIndex.value,
              children: [
                currentPage
              ],
            ),
            bottomSheet: Obx(() {
              return tabController.showSecondBottomSheet.value
                  ? _showBottomSheet(context)
                  : SizedBox.shrink();
            }),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xffD0CDC8), width: 1.0),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: 0, // 수정된 인덱스
                onTap: (index) {


                  if (index == 0) {
                    tabController.showSecondBottomSheet.value = false;

                    if (audioController.isPlaying.value) {
                      audioController.stopAudio();
                    }

                    tabController.pageName.value = 'Home';
                  } else if (index == 1) {
                    tabController.showSecondBottomSheet.value = false;

                    if(tabController.isMain.value) {

                      _controller.canWritePoem.value ?
                      showDialog(
                      context: context,
                      builder: (BuildContext context) => CircleMenuDialog(),
                      ) : showDialog(
                        context: context,
                        builder: (BuildContext context) => (InspirationDoneModal()),
                      );
                    }
                    else if (Get.find<WriteEditViewModel>().isFormComplete.value) {
                      // isMain이 false이면서 제목과 본문이 모두 입력되었을 때 EmotionAnalysisModal 표시
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => EmotionAnalysisModal(),
                      );
                    }
                  } else if (index == 2) {

                    tabController.showSecondBottomSheet.value =
                    !tabController.showSecondBottomSheet.value;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/home.svg', width: 24, height: 24),
                        const Text('홈으로', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/home_ment.svg', width: 44, height: 44),
                      ],
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/menu.svg', width: 24, height: 24),
                        const Text('메뉴', style: TextStyle(fontSize: 10)),
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
              ),
            ),
          );
        }),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                _buildPopupMenu('마이페이지', 'assets/images/mypage.svg', 'Profile'),
                _buildPopupMenu('작업실', 'assets/images/study-lamp.svg', 'Profile'),
                _buildPopupMenu('도서관', 'assets/images/library.svg', 'Profile'),
                _buildPopupMenu('스토어', 'assets/images/store.svg', 'Profile'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopupMenu(String label, String image, String movePage) {
    return InkWell(
      onTap: () {

        if (audioController.isPlaying.value) {
          audioController.stopAudio();
        }

        tabController.showSecondBottomSheet.value = false;
        tabController.pageName.value = movePage;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(image, width: 24, height: 24),
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
      ),
    );
  }
}
