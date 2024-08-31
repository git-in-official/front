import 'package:flutter/material.dart';
import 'highlight_text.dart';

const Color defaultHighlightColor = Color(0xffD2FF40);
const Color defaultForegroundColor = Color(0xFF3B3731);
const Color defaultBackgroundColor = Color(0xFFE3DED4);

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool isHighlighted;
  final Color highlightColor;
  final bool hasIcon;
  final Icon? icon;
  final TextStyle? textStyle;
  final Color foregroundColor;
  final Color backgroundColor;

  const CustomTextButton({
    required this.text,
    this.onPressed,
    this.width = 152,
    this.height = 44,
    this.isHighlighted = false,
    this.highlightColor = defaultHighlightColor,
    this.hasIcon = false,
    this.icon,
    this.textStyle,
    this.foregroundColor = defaultForegroundColor,
    this.backgroundColor = defaultBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = TextStyle(
      fontFamily: 'KoPub Batang',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 1.125, // CSS의 line-height와 동일
      color: Color(0xFF3B3731), // 버튼 텍스트 색상
    );

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: Color(0xFF373430), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasIcon && icon != null) ...[
            icon!,
            SizedBox(width: 4),
          ],
          isHighlighted
              ? HighLightedText(
            text,
            color: highlightColor,
            textStyle: textStyle ?? defaultTextStyle,
          )
              : Text(
            text,
            style: textStyle ?? defaultTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
