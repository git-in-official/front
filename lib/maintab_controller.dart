import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MainTabController extends GetxController {
  var selectedEmotionIndex = (-1).obs; //감정 선택 후 보여줄 이미지 선택
  var showSecondBottomSheet = false.obs; // 보조하단 탭
}