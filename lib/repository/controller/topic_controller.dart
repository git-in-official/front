import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../ui/view_model/write_edit_view_model.dart';

class TopicController extends GetxController {
  var type = 'title'.obs;
  var topic = ''.obs; // 상태 변수를 추가하여 데이터 저장
  var isLoading = true.obs; // 로딩 상태를 나타내는 변수

  final WriteEditViewModel writeEditViewModel = Get.find();

  final AudioPlayer player = AudioPlayer();


  TopicController(String initialType) {
    type.value = initialType;
  }


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


  Future<void> fetchData() async {
    var _baseUrl = 'https://api.leemhoon.com';
    var restUrl;

    switch (type.value) {
      case 'title':
        restUrl = "/inspirations/title";
        break;
      case 'word':
        restUrl = "/inspirations/word";
        break;
      case 'audio':
        restUrl = "/inspirations/audio";
        break;
      case 'video':
        restUrl = "/inspirations/video";
        break;
      default:
        restUrl = "/inspirations/title";
        break;
    }

    try {
      final uri = Uri.parse('$_baseUrl$restUrl');

      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(uri, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseJson = json.decode(response.body);

        switch (type.value) {
          case 'title':
            writeEditViewModel.inspirationId = responseJson['id'];
            topic.value = responseJson['title'];
            break;
          case 'word':
            print(responseJson['word']);
            writeEditViewModel.inspirationId = responseJson['id'];

            topic.value = responseJson['word'];
            break;
          case 'audio':
            print(responseJson['audioUrl']);
            writeEditViewModel.inspirationId = responseJson['id'];

            topic.value = responseJson['audioUrl'];
            break;
          case 'video':
            print(responseJson['videoUrl']);
            writeEditViewModel.inspirationId = responseJson['id'];
            topic.value = responseJson['videoUrl'];
            break;
          default:
            topic.value = '잘못되었음';
        }
      } else {
        topic.value = '에러: ${response.statusCode}';
      }
    } finally {
      isLoading.value = false;
    }
  }
}