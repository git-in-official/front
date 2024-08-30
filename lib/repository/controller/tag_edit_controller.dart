import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../ui/view_model/write_edit_view_model.dart';
import 'auth_service.dart';
import 'dontCommit.dart';

class TagEditController extends GetxController {
  final WriteEditViewModel getPoemDetail = Get.find();


  Future<void> changeTags(String which, List<String> changeTags) async {
    String baseUrl = "https://api.leemhoon.com";
    String url = "$baseUrl/poems/tag";

    final authService = AuthService();
    // final token = await authService.loadServiceTokens();
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };


    Map<String, dynamic> body = {
      "title": getPoemDetail.title.value,
      "beforeThemes": getPoemDetail.themes.toList(),
      "beforeInteractions": getPoemDetail.interactions.toList(),
      "afterThemes": which == '테마' ? changeTags : getPoemDetail.themes.toList(),
      "afterInteractions": which == '테마'
          ? getPoemDetail.interactions.toList()
          : changeTags,
      "content": getPoemDetail.bodyContent.value
    };

    final EmotionAnalysisController emotionController = Get.find();

    if (which == '테마') {
      emotionController.themes = changeTags;
    }
    else {
      emotionController.interactions = changeTags;
    }


    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("성공입니달ㅇ: ${response.body}");
        final Map<String, dynamic> responseJson = json.decode(response.body);
        getPoemDetail.title.value = responseJson['title'];
        getPoemDetail.bodyContent.value = responseJson['content'];
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        print("유효성 아니면 검증 실패: ${response.statusCode}");
      } else {
        print("다른에러: ${response.statusCode}");
      }
    } catch (error) {
      print("ㄱ걍 에러: $error");
    }
  }
}

