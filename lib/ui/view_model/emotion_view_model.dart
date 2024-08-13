import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:to_morrow_front/data/model/emotion_model.dart';
import 'package:to_morrow_front/repository/emotion_repository.dart';
import 'dart:convert';

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

    await sendEmotionToServer(emotion);

    // 감정 선택 후 다음 페이지로 이동
    Get.toNamed('/nextPage');
  }

  Future<void> sendEmotionToServer(EmotionModel emotion) async {
    final url = Uri.parse('');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': emotion.title,
      }),
    );

    if (response.statusCode == 200) {
      print('서버 연결 성공');
    } else {
      print('서버 연결 실패');
    }
  }

}