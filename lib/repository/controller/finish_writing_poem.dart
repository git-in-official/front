import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';
import 'package:http/http.dart' as http;

import '../../data/model/poem_response.dart';
import 'auth_service.dart';


class FinishWritingPoem extends GetxController {
  final WriteEditViewModel getPoemDetail = Get.find();

  Future<void> donePoem() async {
    String baseUrl = "https://api.leemhoon.com";
    String url = "$baseUrl/poems";

    final authService = AuthService();
    // final token = await authService.loadServiceTokens();
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    String? base64Audio; //오디오파일 바이너리문자변경
    if (getPoemDetail.audioFile.value.isNotEmpty) {
      final audioFile = File(getPoemDetail.audioFile.value);
      if (await audioFile.exists()) {
        final fileBytes = await audioFile.readAsBytes();
        base64Audio = base64Encode(fileBytes);
      }
    }

    Map<String, dynamic> body = {
      "title": getPoemDetail.title.value,
      "content": getPoemDetail.bodyContent.value,
      "themes": getPoemDetail.themes.toList(),
      "interactions": getPoemDetail.interactions.toList(),
      "textAlign": getPoemDetail.textAlign.value,
      "textSize": getPoemDetail.fontSize.value,
      "textFont": getPoemDetail.selectedFont['family'],
      "originalContent": getPoemDetail.originalContent.value.isEmpty
          ? null
          : getPoemDetail.originalContent.value,
      "originalTitle": getPoemDetail.originalTitle.value.isEmpty
          ? null
          : getPoemDetail.originalTitle.value,
      "inspirationId": getPoemDetail.inspirationId.value,
      "audioFile": base64Audio,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("성공입니달ㅇ: ${response.body}");

        final poemResponse = PoemResponse.fromJson(jsonDecode(response.body));

        print("제목: ${poemResponse.title}");
        print("상태: ${poemResponse.status}");


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
