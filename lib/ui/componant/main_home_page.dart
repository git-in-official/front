import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container (
                padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
            child : Text(
              '니가 어떤 딸인데 그러니',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff373430),
              ),
              textAlign: TextAlign.center,
            ),
        ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'user001',
                style: TextStyle(fontSize: 14, color: Color(0xff6D675F)),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Text(
                    '너 훌쩍이는 소리가\n네 어머니 귀에는 천둥소리라 하더라.\n그녀를 닮은 얼굴로 서럽게 울지마라.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff373430),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
