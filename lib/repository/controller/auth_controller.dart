import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:to_morrow_front/data/model/login_user_info.dart';
import 'package:to_morrow_front/repository/controller/login_controller.dart';

import 'auth_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final String _baseUrl = 'https://api.leemhoon.com/auth';
  final LoginUserInfo user = LoginUserInfo();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<LoginUserInfo?> signUp(String name) async {
    final url = Uri.parse('$_baseUrl/signup');
    final provider = await storage.read(key: 'loginPlaform');
    final providerAccessToken = AuthService().loadTokens();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'provider': provider,
          'providerAccessToken': providerAccessToken,
          'name': name,
        })
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user.accessToken = data.accessToken;
        user.name = data.name;
        isLoggedIn.value = true;
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }

  Future<LoginUserInfo?> login(String providerAccessToken) async {
    final url = Uri.parse('$_baseUrl/login');
    final storedPlatform = await storage.read(key: 'loginPlatform');
    final googleAccessToken = AuthService().loadTokens();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'provider': storedPlatform,
          'providerAccessToken': providerAccessToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user.accessToken = data.accessToken;
        user.name = data.name;
        isLoggedIn.value = true;
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }

  void logout() {
    isLoggedIn.value = false;
    // 구글 로그인 정보 삭제
    AuthService().deleteToken();
    LoginController().signOut();
  }
}