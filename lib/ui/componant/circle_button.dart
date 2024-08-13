import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleMenuDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: CircleMenu(),
    );
  }
}

class CircleMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 큰 원형 배경
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFFE6E2DB),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFE7E6E4), width: 1),
              ),
              child: CustomPaint(
                painter: CircleDiagonalLinePainter(),
              ),
            ),
            // 작은 원형 버튼들
            Positioned(
              top: 33,
              child: CircleButton(icon: Icons.person, label: "단어"),
            ),
            Positioned(
              bottom: 33,
              child: CircleButton(icon: Icons.menu_book_sharp, label: "소리"),
            ),
            Positioned(
              left: 33,
              child: CircleButton(icon: Icons.store, label: "제목"),
            ),
            Positioned(
              right: 33,
              child: CircleButton(icon: Icons.smart_display, label: "영상"),
            ),
            // 중앙 아이콘
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF373430),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E2DB),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/icon.png', width: 24, height: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const CircleButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 45,
          height: 45,
          child: Icon(icon, color: Colors.black, size: 26),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'KoPub Batang',
            fontSize: 10,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}

class CircleDiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFBDBDBD)
      ..strokeWidth = 1;

    // 원의 중심
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4;

    final topLeft = Offset(center.dx - radius, center.dy - radius);
    final topRight = Offset(center.dx + radius, center.dy - radius);
    final bottomLeft = Offset(center.dx - radius, center.dy + radius);
    final bottomRight = Offset(center.dx + radius, center.dy + radius);

    canvas.drawLine(topLeft, bottomRight, paint);
    canvas.drawLine(topRight, bottomLeft, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
