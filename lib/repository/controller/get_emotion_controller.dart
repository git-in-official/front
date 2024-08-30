import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:to_morrow_front/data/model/emotion_model.dart';
import 'auth_service.dart';

class GetEmotionController extends GetxController {
  var _baseUrl = 'https://api.leemhoon.com';

  Future<List<EmotionModel>> fetchEmotion() async {
    try {
      final uri = Uri.parse('$_baseUrl/emotions');
      final authService = AuthService();
      final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) {
          final emotionModel = EmotionModel.fromJson(e);
          return emotionModel.copyWith(
            iconPath: _getIconPathForEmotion(emotionModel.title),
          );
        }).toList();
      } else {
        print('GetEmotionController 에러 발생: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
      return [];
    }
  }

  String _getIconPathForEmotion(String emotion) {
    switch (emotion) {
      case '기쁨':
        return 'assets/img/joy.png';
      case '슬픔':
        return 'assets/img/sadness.png';
      case '두려움':
        return 'assets/img/fear.png';
      case '분노':
        return 'assets/img/anger.png';
      case '기대':
        return 'assets/img/anticipation.png';
      case '신뢰':
        return 'assets/img/trust.png';
      case '모르겠음':
        return 'assets/img/uncertainty.png';
      default:
        return 'assets/img/joy.png';
    }
  }
}
