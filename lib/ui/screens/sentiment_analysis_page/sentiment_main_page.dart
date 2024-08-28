import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//글쓰기페이지(감정분석)
class SentimentMainPage extends StatelessWidget {
  const SentimentMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 135.0,),
                SvgPicture.asset(
                  'assets/icons/writing_page/to_morrow_mini_icon.svg',
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'TO.MORROW가\n~님이 탈고하신\n‘시 제목’의 마음을\n읽어내는 중입니다..',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, fontFamily: 'KoPubBatangPro',),
                ),
                SizedBox(height: 68.0,),
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
                      '확인',
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
