import 'package:flutter/material.dart';
import 'package:to_morrow_front/ui/widgets/my_page_appBar.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 1),
              Text('계정 및 프로필'),
          ],
        ),
      ),
      body: Text('테스트'),
    );
  }
}
