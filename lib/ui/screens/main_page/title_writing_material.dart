import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleWritinMaterial extends StatelessWidget {
  const TitleWritinMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/main_menu/main_menu_icon.svg',
                  width: 64.0,
                  height: 64.0,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  '오늘의 제목글감을 알려드립니다.',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'KoPubBatangPro'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  '글감이 나오는 곳',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'KoPubBatangPro',
                  ),

                ),
                const SizedBox(
                  height: 259.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF373430),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      '글쓰기',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'KoPubBatangPro',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
