import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/auth_service.dart';
import 'package:http/http.dart' as http;

// GetX의 컨트롤러를 사용하기 위해 GetxController를 상속합니다.
class UserController extends GetxController {
  final String _baseUrl = 'https://api.leemhoon.com'; // API의 기본 URL
  final Future<String?> accessToken = AuthService().loadServiceTokens(); // AuthService에서 액세스 토큰을 가져옵니다.

  var profileData = {}.obs; // 사용자 프로필 데이터를 관찰 가능한 상태로 저장
  var isLoading = false.obs; // 로딩 상태를 관찰 가능한 상태로 저장

  // 사용자 프로필 정보를 가져오는 함수
  Future<void> getMyProfileInfo() async {
    final url = Uri.parse('$_baseUrl/user/profile'); // 프로필 정보를 가져올 API의 엔드포인트

    try {
      isLoading.value = true; // 데이터 로딩 중임을 표시
      final String? token = await accessToken; // 비동기로 액세스 토큰을 가져옵니다.

      if (token == null) {
        // accessToken이 null인 경우 예외 처리
        print('AccessToken is null. Please login again.'); // 액세스 토큰이 없을 경우 에러 메시지 출력
        isLoading.value = false; // 로딩 상태 종료
        return;
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Bearer 토큰으로 인증
        },
      );

      print(response.body); // 서버로부터의 응답을 콘솔에 출력

      if (response.statusCode == 200) {
        // 성공적으로 응답을 받은 경우
        final data = jsonDecode(response.body); // JSON 응답을 디코딩
        profileData.value = data; // 프로필 데이터를 업데이트
      } else {
        print('Failed to fetch profile data. Status code: ${response.statusCode}'); // 실패 시 에러 메시지 출력
      }
    } catch (e) {
      print("Error during fetching profile: $e"); // 요청 중 예외 발생 시 에러 메시지 출력
    } finally {
      isLoading.value = false; // 로딩 상태 종료
    }
  }
}