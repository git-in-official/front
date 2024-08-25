import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../ui/component/emotion_view.dart';
import '../../ui/screens/register_page/register_page.dart';
import 'auth_service.dart';
import 'global_controller.dart';

class LoginController extends GetxController {
  final _global = Get.find<GlobalController>();

  Future<void> signInWithGoogle() async {

    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        String accessToken = googleAuth.accessToken.toString();

        final authService = AuthService();
        await authService.saveToken(googleAuth.accessToken!);
        await saveLoginPlatform(LoginPlatform.google);



        _global.updateUserInfo(googleUser, LoginPlatform.google);
        print("Global controller updated with user info: ${googleUser.displayName}");
        String name = googleUser.displayName.toString();

        loginToServer(accessToken, name);

      }
    } catch (error) {
      print("@@@@@@@@@@@@@@@@@@@@ $error");
    }

  }

  Future<void> loginToServer(String providerAccessToken, String name) async {

    //배포사이트
    String baseUrl = "https://api.leemhoon.com";

    String url = "$baseUrl/auth/login";

    print(providerAccessToken);

    Map<String, String> body = {
      "provider": "google",
      "providerAccessToken": providerAccessToken,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("Login successful: ${response.body}");

        final Map<String, dynamic> responseJson = json.decode(response.body);

        // 액세스 토큰과 이름 추출
        final String accessToken = responseJson['accessToken'];
        final String name = responseJson['name'];

        final authService = AuthService();

        await authService.saveServiceToken(accessToken);
        await authService.saveServiceName(name);

        //바로 기분 선택 페이지
        Get.to(() => EmotionView());
      } else if (response.statusCode == 404 &&
          responseBody['message'] == "user not found") {
        print("404 - 회원가입필요");
        //필명페이지 ㄱ
        Get.to(() => RegisterPage());
      } else {
        print("Failed to login: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error during login: $error");
    }
  }

//필명 페이지에서 입력 완료 하면 실행
  Future<void> goToSignup(String name) async {

    final authService = AuthService();
    final tokens = await authService.loadTokens();

    final providerAccessToken = tokens['googleAccessToken']!;


    String baseUrl = "https://api.leemhoon.com";

    String url = "$baseUrl/auth/signup";

    Map<String, String> body = {
      "provider": "google",
      "providerAccessToken": providerAccessToken,
      "name": name
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("가입  ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("signUp successful : ${response.body}");

        final Map<String, dynamic> responseJson = json.decode(response.body);

        // 액세스 토큰과 이름 추출
        final String accessToken = responseJson['accessToken'];
        final String name = responseJson['name'];

        await authService.saveServiceToken(accessToken);
        await authService.saveServiceName(name);



        // 기분선택페이지로 ㄱ
        Get.to(() => EmotionView());
      } else {
        print("Failed to login: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error during login: $error");
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    switch (_global.user.value.loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      // case LoginPlatform.apple:
      //   break;
      case LoginPlatform.none:
        break;
    }

    // FlutterSecureStorage accessToken 삭제
    final authService = AuthService();
    await authService.deleteToken();

    // FlutterSecureStorage 로그인 플랫폼 삭제
    await saveLoginPlatform(LoginPlatform.none);

    // 글로벌 컨트롤러 초기화
    _global.resetUserInfo();
    print('로그아웃');
  }

  // 로그인 플랫폼 저장
  Future<void> saveLoginPlatform(LoginPlatform platform) async {
    await _global.storage.write(
        key: 'loginPlatform', value: platform.toString().split('.').last);
  }
}


