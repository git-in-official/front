import 'package:flutter/cupertino.dart';

class HighLightedText extends StatelessWidget {
  final String data;
  final Color color;
  final TextStyle textStyle;

  const HighLightedText(
      this.data, {
        super.key,
        required this.color,
        required this.textStyle,
      });

  Size getTextSize({
    required String text,
    required TextStyle style,
    required BuildContext context,
  }) {
    final Size size = (TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    final Size textSize = getTextSize(
      text: data,
      style: textStyle,
      context: context,
    );
    return Stack(
      children: [
        Text(data, style: textStyle),
        Positioned(
          top: textSize.height / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: color.withOpacity(0.4),
            ),
            height: textSize.height / 2,
            width: textSize.width,
          ),
        )
      ],
    );
  }
}