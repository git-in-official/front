
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/user.dart';


class GlobalController extends GetxController {
  static GlobalController get instance => Get.find();
  final FlutterSecureStorage storage = FlutterSecureStorage();


  var user = User().obs;

  Future initData() async {

  }
  GlobalController(){
    checkLoginStatus();
  }
  double? myLat ;
  double? myLng ;


  /// 사용자 정보 업데이트
  /// GoogleSignInAccount(displayName, email, id, photoUrl)
  void updateUserInfo(GoogleSignInAccount googleUser, LoginPlatform platform) async {
    user.update((user) {
      user?.userName = googleUser.displayName ?? '';
      user?.userEmail = googleUser.email;
      user?.photoUrl = googleUser.photoUrl ?? '';
      user?.loginPlatform = platform;
    });
  }

  void resetUserInfo() async {
    user.update((user) {
      user?.userName = '';
      user?.userEmail = '';
      user?.photoUrl = '';
      user?.loginPlatform = LoginPlatform.none;
    });
  }

  // 로그인 상태 확인 및 복원
  void checkLoginStatus() async {

    final storedPlatform = await storage.read(key: 'loginPlatform');

    if (storedPlatform != null && storedPlatform == 'google') {

      // storage에 저장되어 있는 accessToken 가져오기
      final accessToken = await storage.read(key: 'accessToken');

      if (accessToken != null) {

        // 토큰의 유효성을 확인하는 요청
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();

        // 토큰이 유효하니 바로 로그인처리
        if(googleUser != null){


          //loginPlatform.value = LoginPlatform.google;
          user?.value.loginPlatform = LoginPlatform.google;


          updateUserInfo(googleUser, LoginPlatform.google);

        }else{

          // 토큰이 유효하지 않으면 로그아웃 처리
          //loginPlatform.value = LoginPlatform.none;


          user?.value.loginPlatform = LoginPlatform.none;


        }

      }else{
        // 토큰이 없다면 로그인 필요
        //loginPlatform.value = LoginPlatform.none;


        user?.value.loginPlatform = LoginPlatform.none;

      }
    }
  }
}

enum LoginPlatform {
  google,
  none, // logout
}