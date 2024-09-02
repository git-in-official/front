import 'package:flutter/material.dart';

class MyDisableAchievement extends StatelessWidget {
  const MyDisableAchievement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E2DB),
        titleSpacing: 16,
        // leadingWidth: 40.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '업적',
              style: TextStyle(
                fontFamily: 'KoPubBatangPro',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          // 칭호 밑에 회색 선
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFBDBDBD),
            height: 1.0,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 124.0,),
              Image.asset(
                'assets/img/badge_number_one.svg',
                height: 201.0,
                width: 187.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '업적명',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '이 칭호를 얻으려면 ~ 를 하세요.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 32.0,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF83817F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '대표 업적으로 변경하기',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
