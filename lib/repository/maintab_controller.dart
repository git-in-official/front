import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ui/screens/main_page/main_home_page.dart';
import '../ui/screens/my_page/my_profile.dart';

class MainTabController extends GetxController {
  var selectedEmotionIndex = (-1).obs; //감정 선택 후 보여줄 이미지 선택
  var showSecondBottomSheet = false.obs; // 보조하단 탭


  RxInt rootPageIndex = 0.obs; //현재 선택 된 탭의 인덱스
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); //키 주입



  //선택 된 pageName
  RxString pageName = 'Home'.obs;


  Future<bool> onWillPop() async {
    return !await navigatorKey.currentState!.maybePop();
  }



  void back() {
    onWillPop();
  }

}