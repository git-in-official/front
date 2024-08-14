import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      // Optional clientId
      // clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // 로그인 성공
        print ("로그인성공");
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // FlutterSecureStorage accessToken 저장
        final authService = AuthService();
        await authService.saveToken(googleAuth.accessToken!);

        // FlutterSecureStorage 로그인 플랫폼 저장
        await saveLoginPlatform(LoginPlatform.google);

        // 글로벌 컨트롤러에 로그인 정보 저장
        _global.updateUserInfo(googleUser, LoginPlatform.google);
      }
    } catch (error) {
      print("@@@@@@@@@@@@@@@@@@@@ $error");
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
