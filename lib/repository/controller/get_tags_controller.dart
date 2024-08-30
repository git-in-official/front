import 'dart:convert'; // 추가: jsonDecode를 사용하기 위해 import
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetTagsController extends GetxController {
  var _baseUrl = 'https://api.leemhoon.com/tags';

  var themes = <String>[].obs;
  var interactions = <String>[].obs;
  var isLoading = true.obs; // 데이터 로딩 상태를 추적

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true; // 데이터 로딩 시작
    try {
      final uri = Uri.parse(_baseUrl);
      final response = await http.get(uri);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('themes')) {
          themes.value = List<String>.from(jsonResponse['themes']);
        }
        if (jsonResponse.containsKey('interactions')) {
          interactions.value = List<String>.from(jsonResponse['interactions']);
        }
      } else {
        print('에러 발생: ${response.statusCode}');
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
    } finally {
      isLoading.value = false; // 데이터 로딩 완료
    }
  }
}

