import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../data/model/poem_response.dart';
import 'auth_service.dart';

class FinishWritingPoem extends GetxController {
  final WriteEditViewModel getPoemDetail = Get.find();
  RxInt remainingEdits = 5.obs;

  Future<void> donePoem() async {
    String baseUrl = "https://api.leemhoon.com";
    String url = "$baseUrl/poems";

    final authService = AuthService();
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers);

    request.fields['title'] = getPoemDetail.title.value;
    request.fields['content'] = getPoemDetail.bodyContent.value;
    request.fields['textAlign'] = getPoemDetail.textAlign.value;
    request.fields['textSize'] = getPoemDetail.fontSize.value.toString();
    request.fields['textFont'] = getPoemDetail.selectedFont['family'] as String;
    request.fields['originalContent'] =
        getPoemDetail.originalContent.value.isEmpty
            ? ''
            : getPoemDetail.originalContent.value;
    request.fields['originalTitle'] = getPoemDetail.originalTitle.value.isEmpty
        ? ''
        : getPoemDetail.originalTitle.value;
    request.fields['inspirationId'] = getPoemDetail.inspirationId.value;

    //테마
    final themes = getPoemDetail.themes.toList();
    for (int i = 0; i < themes.length; i++) {
      request.fields['themes[$i]'] = themes[i];
    }

    //상호작용
    final interactions = getPoemDetail.interactions.toList();
    for (int i = 0; i < interactions.length; i++) {
      request.fields['interactions[$i]'] = interactions[i];
    }

    if (getPoemDetail.audioFile.value.isNotEmpty) {
      final audioFile = File(getPoemDetail.audioFile.value);
      if (await audioFile.exists()) {
        final fileBytes = await audioFile.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'audioFile',
            fileBytes,
            filename: 'audio.mp3',
            contentType: MediaType('audio', 'mp3'),
          ),
        );
      }
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response Body: $responseBody"); // 응답 본문 출력
      print("Response Status Code: ${response.statusCode}"); // 상태 코드 출력


      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("성공: ${responseBody}");
        final poemResponse = PoemResponse.fromJson(jsonDecode(responseBody));

        // (2) 서버 응답에서 'count' 값을 가져와 remainingEdits에 저장
        final responseJson = jsonDecode(responseBody);
        remainingEdits.value = responseJson['count'] ?? 0;

        // (3) 남은 탈고 횟수 출력
        print("오늘 가능한 탈고 횟수: ${remainingEdits.value}");


        print("제목: ${poemResponse.title}");
        print("상태: ${poemResponse.status}");
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        print("유효성 검사 실패 또는 인증 실패: ${response.statusCode}");
        print("응답 본문: ${responseBody}");
      } else {
        print("서버 오류: ${response.statusCode}");
        print("응답 본문: ${responseBody}");
      }
    } catch (error) {
      print("에러 발생: $error");
    }
  }
}
