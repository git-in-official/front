import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text_button.dart';

class FinalAskModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffE6E2DB),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        width: 280,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFE6E2DB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, size: 24),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Text(
              '탈고 후에는 수정이 어렵습니다.\n낭독하신 원고를 제출하시겠습니까?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'KoPub Batang',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            CustomTextButton(text: '낭독 없이 탈고하겠습니다.',  height : 44, width: 203,onPressed: () {}),
            SizedBox(height: 15),
            CustomTextButton(text: '다시 낭독하겠습니다.', height : 44, width: 203, onPressed: () {}),
            SizedBox(height: 15),
            CustomTextButton(
              text: '낭독한 시를 탈고하겠습니다.',
              isHighlighted: true, height : 44, width: 203,
              onPressed: () {},
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
