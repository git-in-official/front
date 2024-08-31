import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class CircleButtonController extends GetxController {
  var _baseUrl = 'https://api.leemhoon.com/poems/remain';

  var canWritePoem = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
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

      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {

        final responseBody = jsonDecode(response.body);

        print (responseBody["count"] );

        if (responseBody["count"] != 0) {
          print('시를 쓸 수 있다');

          canWritePoem.value = true;
        } else {
          print('시 2번 다씀');

          canWritePoem.value = false;
        }
      } else if (response.statusCode == 400) {
        print('시 2번 다씀');
        canWritePoem.value = false;
      } else {
        print('에러 발생: ${response.statusCode}');
        canWritePoem.value = false;
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
      canWritePoem.value = false;
    }
  }
}
