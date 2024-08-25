import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_morrow_front/repository/controller/login_controller.dart';

import '../../component/bottom_navigation_bar.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      body: Stack(
        children: [
          AnimatedPositionedLogo(),
        ],
      ),
    );
  }
}

class AnimatedPositionedLogo extends StatefulWidget {
  @override
  _AnimatedPositionedLogoState createState() => _AnimatedPositionedLogoState();
}

class _AnimatedPositionedLogoState extends State<AnimatedPositionedLogo> {
  bool _small = false;
  String? accessToken;
  bool _hasText = false;

  final LoginController loginController = Get.find<LoginController>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _small = true;
    _loadToken();
    _nameController
        .addListener(_updateHasText);
  }

  Future<void> _loadToken() async {
    final authService = AuthService();
    final tokens = await authService.loadTokens();
    setState(() {
      accessToken = tokens['accessToken'].toString();
    });
  }

  void _updateHasText() {
    final text = _nameController.text;
    setState(() {
      _hasText = _validateText(text);
    });
  }

  bool _validateText(String text) {
    bool isKorean =
    true;
    final isValidLength = isKorean
        ? (text.length >= 2 && text.length <= 14)
        : (text.length >= 3 && text.length <= 20);
    final validChars = RegExp(isKorean
        ? r'^[가-힣a-zA-Z0-9_-]+$' // Korean
        : r'^[A-Za-z0-9_-]+$'); // American

    return isValidLength && validChars.hasMatch(text);
  }

  void _onSubmit() {
    final name = _nameController.text;
    loginController.goToSignup(accessToken!, name);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 204, end: _small ? 126 : 204),
      duration: Duration(seconds: 2),
      builder: (context, double topValue, child) {
        return Positioned(
          top: topValue,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 120, end: _small ? 64 : 120),
              duration: Duration(seconds: 2),
              builder: (context, double size, child) {
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: size / 2),
                  duration: Duration(seconds: 2),
                  builder: (context, double radius, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: SizedBox(
                            width: size,
                            height: size,
                            child: child,
                          ),
                        ),
                        SizedBox(height: 20),
                        const Text(
                          '안녕하세요, 투모로우입니다.\n작가님의 필명을 알려주세요.',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'KoPubBatangPro',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 36),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              TextField(
                                controller: _nameController,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0,
                                ),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      decoration: TextDecoration.none,
                                    ),
                                    labelText: " 필명 입력",
                                    labelStyle: TextStyle(
                                      color: Color(0xff9E9E9E),
                                      fontSize: 16,
                                      fontFamily: 'KoPubBatangPro',
                                    ),
                                    contentPadding: EdgeInsets.only(left: 8.0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffBDBDBD),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff373430),
                                        width: 1.0,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    // errorText: _hasText ? null : "2글자 이상의 한글, 영어, 숫자, 밑줄, 하이픈만 사용 가능합니다."
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  _hasText ? _onSubmit : null;
                                  Get.to(() => Maintab());

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _hasText
                                      ? Color(0xff373430)
                                      : Color(0xff9E9E9E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '입력 완료',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  child: Image.asset('assets/images/logo_large.png'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
