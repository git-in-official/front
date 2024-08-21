import 'package:flutter/material.dart';

class MyProfileEdit extends StatelessWidget {
  const MyProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E2DB),
        title: const Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back_ios_new),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            const SizedBox(width: 1),
            const Text(
              '설정',
              style: TextStyle(
                  fontFamily: 'KoPubBatangPro', fontWeight: FontWeight.w700),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFBDBDBD),
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
