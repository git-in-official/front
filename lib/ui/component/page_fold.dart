
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoldedCornerContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color cornerColor;
  final double foldAmount;
  final double lineAnimation;

  const FoldedCornerContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.cornerColor,
    required this.foldAmount,
    required this.lineAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: FoldedCornerPainter(
        backgroundColor: backgroundColor,
        cornerColor: cornerColor,
        foldAmount: foldAmount,
        lineAnimation: lineAnimation,
      ),
    );
  }
}

class FoldedCornerPainter extends CustomPainter {
  final Color backgroundColor;
  final Color cornerColor;
  final double foldAmount;
  final double lineAnimation;

  FoldedCornerPainter({
    required this.backgroundColor,
    required this.cornerColor,
    required this.foldAmount,
    required this.lineAnimation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, size.height - size.width * foldAmount),
      Offset(size.width * foldAmount, size.height),
      linePaint,
    );


    // 삼각형의 배경색과 그림자 효과를 설정
    final foldedPaint = Paint()
      ..color = Color(0xFFEFEDEB)  // 배경색: #EFEDEB
      ..style = PaintingStyle.fill;

    // 삼각형을 그릴 때 사용할 그림자
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.06)  // 첫 번째 그림자 색상: rgba(0, 0, 0, 0.06)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);  // 그림자 블러 효과

    final foldedPath = Path()
      ..moveTo(size.width * foldAmount, 523)  // 시작점 (삼각형의 꼭지점을 조절)
      ..lineTo(size.width * foldAmount, size.height)  // 두 번째 점
      ..lineTo(0, size.height - size.width * foldAmount)  // 세 번째 점
      ..close();  // 도형을 닫아 삼각형을 완성

    canvas.drawPath(foldedPath, shadowPaint);
    canvas.drawPath(foldedPath, foldedPaint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is FoldedCornerPainter &&
        (oldDelegate.foldAmount != foldAmount ||
            oldDelegate.backgroundColor != backgroundColor ||
            oldDelegate.cornerColor != cornerColor ||
            oldDelegate.lineAnimation != lineAnimation);
  }
}
