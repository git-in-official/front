import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AnimationControllerController extends GetxController {
  var isAnimating = false.obs; // 애니메이션 상태 관리
  var showStopIcon = false.obs; // Stop 아이콘 표시 여부 관리
}

class RecordingController extends GetxController {
  var isVisible = true.obs; // 낭독 종료 후 저장 했을 때
}