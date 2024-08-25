import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:to_morrow_front/repository/controller/global_controller.dart';
import 'package:to_morrow_front/repository/controller/login_controller.dart';

import '../../component/bottom_navigation_bar.dart';
import '../register_page/register_page.dart';

class SplashPage extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      body: Stack(
        children: [
          Positioned(
            left: 32,
            top: 96,
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: Colors.grey, end: Colors.black),
              duration: const Duration(seconds: 2),
              builder: (context, color, child) {
                return Text(
                  'TO.MORROW',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'KoPubBatangPro',
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                );
              },
            ),
          ),
          Positioned(
              top: 204,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedLogo(),
              )),
          Positioned(
            top: 410,
            right: 0,
            height :104,
            width: MediaQuery.sizeOf(context).width,
            child: AnimatedSlideText(),
          ),
          Positioned(
            top: 514,
            right: 32,
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: Colors.grey, end: Colors.black),
              duration: const Duration(seconds: 2),
              builder: (context, color, child) {
                return Text(
                  'From.You',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'KoPubBatangPro',
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                );
              },
            ),
          ),
          Positioned(
              top: 576,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedLogin(),
              )),
        ],
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // 시작 투명도
      end: 1.0, // 끝 투명도
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Image.asset('assets/images/logo_large.png', width: 120, height: 120),
    );
  }
}

class AnimatedSlideText extends StatefulWidget {
  @override
  _AnimatedSlideTextState createState() => _AnimatedSlideTextState();
}

class _AnimatedSlideTextState extends State<AnimatedSlideText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0), // 화면 오른쪽 밖에서 시작
      end: Offset(0, 0), // 화면 안으로 이동
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: child,
        );
      },
      child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: <Widget>[
              Image.asset(
                'assets/images/poem_background.png',
                fit: BoxFit.fill,
                // fit : BoxFit.cover,
                height: 104,
                width: MediaQuery.sizeOf(context).width,

              ),
              /// Todo. Text 나중에 불러와야함
              Positioned (
                  right: 32,
                  child : Text(
                    '세상은 다시 한 번 고요한 저녁이 온다.\n가을이다, 부디 아프지마라\n\n나태주 - \'멀리서 빈다\' 중에서',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              )

            ]);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class AnimatedLogin extends StatefulWidget {

  @override
  _AnimatedLogin createState() => _AnimatedLogin();
}

class _AnimatedLogin extends State<AnimatedLogin>
    with SingleTickerProviderStateMixin {


  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final _global = Get.find<GlobalController>();

  final LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();


    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // 시작 투명도
      end: 1.0, // 끝 투명도
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (_global.user.value.loginPlatform != LoginPlatform.none) {
      return SizedBox.shrink();
    }

    return FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 1,
                  ),
                ),
                Text(
                  "간편로그인",
                  style: TextStyle(color: Color(0xff3A3A3A)),
                ),
                Expanded(
                  child: Divider(
                    indent: 10.0,
                    endIndent: 20.0,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    loginController.signInWithGoogle();
                  },
                  child: Image.asset(
                    'assets/images/google_login.png',
                    width: 48,
                    height: 48,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // loginController.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Maintab()),
                    );
                  },
                  child: Image.asset('assets/images/apple_login.png',
                      width: 48, height: 48),
                ),
              ],
            )
          ],
        ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var fadeAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: fadeAnimation,
        child: child,
      );
    },
  );
}
