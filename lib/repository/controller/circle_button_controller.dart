import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';


class CircleButtonController extends GetxController {
  var _baseUrl = 'https://api.leemhoon.com/poems/can-write';

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
      final token = await authService.loadServiceTokens();

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(uri, headers: headers);

      print (response.statusCode);


      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('시를 쓸 수 있다');
        canWritePoem.value = true;
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
