import '../../repository/controller/global_controller.dart';


class User {
  String? userName;
  String? userEmail;
  String? photoUrl;
  LoginPlatform loginPlatform;

  User({
    this.userName,
    this.userEmail,
    this.photoUrl,
    this.loginPlatform = LoginPlatform.none,
  });


}