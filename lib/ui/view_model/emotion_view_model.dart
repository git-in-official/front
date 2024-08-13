import 'package:get/get.dart';
import 'package:to_morrow_front/data/model/emotion_model.dart';
import 'package:to_morrow_front/repository/emotion_repository.dart';

class EmotionViewModel extends GetxController {
  var selectedEmotion = Rxn<EmotionModel>();
  var emotions = <EmotionModel>[].obs;

  final EmotionRepository _repository = EmotionRepository();

  @override
  void onInit() {
    super.onInit();
    fetchEmotions();
  }

  void fetchEmotions() {
    emotions.addAll(_repository.fetchEmotion());
  }

  void selectEmotion(EmotionModel emotion) async{
    selectedEmotion.value = emotion;
    // 감정 선택 후 다음 페이지로 이동
    Get.toNamed('/nextPage');
  }

}
