import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';
import 'maintab_controller.dart';

class EmotionViewController extends GetxController {
  final MainTabController tabController = Get.find();

  Future<void> sendEmotionToServer(String emotion) async {
    var _baseUrl = 'https://api.leemhoon.com/emotions/select';


    try {
      final uri = Uri.parse(_baseUrl);

      final authService = AuthService();
      // final token = await authService.loadServiceTokens();
      final token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      Map<String, String> body = {"emotion": emotion};

      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('감정선택내역저장api 성공 : ${response.statusCode}');
      } else {
        print('감정선택내역저장api 실패 : ${response.statusCode}');
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
    }
  }
}
