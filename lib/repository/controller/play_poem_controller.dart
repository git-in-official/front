import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class PlayPoemController extends GetxController{

  var _baseUrl = 'https://api.leemhoon.com';



  Future<void> fetchData(String id) async {
    try {
      final uri = Uri.parse('$_baseUrl/poems/${id}/play');

      final authService = AuthService();
      // final token = await authService.loadServiceTokens();
      final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkxOTY2ZWIyLWQ3OTMtNDVmNi04YjE4LWZkM2ZjZjZkYTZhNyIsImlhdCI6MTcyNDU4OTg1OCwiZXhwIjoxNzI3MTgxODU4fQ.JqZMFiY6xUa7nK7lCRFuUdSwXGhQ8gUzUq6JuCsU22I";

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };



      final response = await http.get(uri, headers: headers);



      if (response.statusCode >= 200 && response.statusCode < 300) {
        print ('낭독횟수 증가 ');
      } else {
        print('에러 발생: ${response.statusCode}');
      }
    } catch (e) {
      print('요청 중 예외 발생: $e');
    }
  }

}