import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  void initState() {
    super.initState();
    _small = true; // 애니메이션을 페이지 로드와 동시에 시작
  }

  // _hasText

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
                      mainAxisSize: MainAxisSize.min, // 내용물 크기만큼만 높이 설정
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
                            fontFamily: 'KoPubWorldBatang',
                          ),
                          textAlign: TextAlign.center, // 텍스트를 가운데 정렬
                        ),
                        SizedBox(height: 36),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const TextField(
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationThickness: 0,
                                  ),
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          decoration: TextDecoration.none),
                                      labelText: " 필명 입력",
                                      labelStyle: TextStyle(
                                        color: Color(0xff9E9E9E),
                                        fontSize: 16,
                                        fontFamily: 'KoPubWorldBatang',
                                      ),
                                      contentPadding: EdgeInsets.only(left: 8.0), // Adjust the vertical padding

                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Color(0xffBDBDBD)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff373430),
                                            width: 1.0),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    // backgroundColor: _hasText ? Color(0xff373430) : Color(0xff9E9E9E),
                                    backgroundColor: Color(0xff9E9E9E), // Button background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0), // Button border radius
                                    ),
                                    padding: EdgeInsets.zero, // Remove default padding
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 48,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '입력 완료',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'KoPubWorldBatang',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    );
                  },
                  child: Image.asset('assets/images/logo.png'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}