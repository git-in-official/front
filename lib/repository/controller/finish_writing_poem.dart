import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../data/model/poem_response.dart';
import 'auth_service.dart';

class FinishWritingPoem extends GetxController {
  final WriteEditViewModel getPoemDetail = Get.find();
  RxnInt remainingEdits = RxnInt();
  var isSendingComplete = false.obs;
  var stage = 0.obs;

  String generateFontString(Map<String, Object> font) {
    final family = font['family'] as String;
    final weight = (font['weight'] as FontWeight).index;
    final name = font['name'] as String;

    return '$family-$weight-$name';
  }


  Future<void> donePoem() async {
    String baseUrl = "https://api.leemhoon.com";
    String url = "$baseUrl/poems";

    final authService = AuthService();
    final token = await authService.loadServiceTokens(); // 서비스 토큰 불러오기

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(headers);

    request.fields['title'] = getPoemDetail.title.value;
    request.fields['content'] = getPoemDetail.bodyContent.value;
    request.fields['textAlign'] = getPoemDetail.textAlign.value;
    request.fields['textSize'] = getPoemDetail.fontSize.value.toString();
    request.fields['textFont'] = generateFontString(getPoemDetail.selectedFont);
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

      if (response.statusCode >= 200 && response.statusCode < 300) {


        // (2) 서버 응답에서 'count' 값을 가져와 remainingEdits에 저장
        final responseJson = jsonDecode(responseBody);
        remainingEdits.value = responseJson['count'];

        // (3) 남은 탈고 횟수 출력
        print("API 통신 오늘 가능한 탈고 횟수: ${remainingEdits.value}");
        isSendingComplete.value = true;

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