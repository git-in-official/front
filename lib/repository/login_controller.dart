import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:to_morrow_front/ui/component/register_page.dart';

import 'global_controller.dart';

class LoginController extends GetxController {
  final _global = Get.find<GlobalController>();

  // 구글 로그인
  Future<void> signInWithGoogle() async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    GoogleSignIn _googleSignIn = GoogleSignIn(
      // // Optional clientId
      // // clientId: 'your-client_id.apps.googleusercontent.com',
      // scopes: scopes,
    );

    try {
      // Attempt to sign in the user with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("GoogleSignInAccount: $googleUser");

      if (googleUser != null) {
        print("로그인성공");

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        print("GoogleSignInAuthentication: ${googleAuth.toString()}");
        print("AccessToken: ${googleAuth.accessToken}");
        print("IdToken: ${googleAuth.idToken}");

        String accessToken = googleAuth.accessToken.toString();

        final authService = AuthService();
        await authService.saveToken(googleAuth.accessToken!);
        print("AccessToken saved to FlutterSecureStorage");

        await saveLoginPlatform(LoginPlatform.google);
        print("Login platform saved as Google");



        _global.updateUserInfo(googleUser, LoginPlatform.google);
        print("Global controller updated with user info: ${googleUser.displayName}");
        String name = googleUser.displayName.toString();

        loginToServer(accessToken, name);

      }
    } catch (error) {
      print("@@@@@@@@@@@@@@@@@@@@ $error");
    }

  }

  Future<void> loginToServer(String providerAccessToken, String name ) async {

    // String baseUrl = "http://10.0.2.2:3000";

    //디버깅모드
    String baseUrl ="http://192.168.0.40:3000";

    String url = "$baseUrl/auth/login";

    print (providerAccessToken);

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
        //바로 메인 페이지 ㄱ

      } else if (response.statusCode == 404 && responseBody['message'] == "user not found") {
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
  Future<void> goToSignup(String providerAccessToken, String name) async {

    print (name);

    String baseUrl ="http://192.168.0.40:3000";

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

      print ("가입  ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("signUp successful : ${response.body}");
        // 메인페이지로 ㄱ
        // Get.to(() => MainPage());

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
    await _global.storage.write(key: 'loginPlatform', value: platform.toString().split('.').last);
  }
}


class AuthService {
  final _global = Get.find<GlobalController>();

  // 토큰 저장
  Future<void> saveToken(String accessToken) async {
    await _global.storage.write(key: 'accessToken', value: accessToken);
  }

  // 토큰 불러오기
  Future<Map<String, String?>> loadTokens() async {
    final accessToken = await _global.storage.read(key: 'accessToken');
    return {'accessToken': accessToken};
  }

  // 토큰 삭제
  Future<void> deleteToken() async {
    await _global.storage.delete(key: 'accessToken');
  }
}
