import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'highlight_text.dart';

const Color defaultHighlightColor = Color(0xffD2FF40);

class CustomTextButton extends StatelessWidget {


  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool isHighlighted;
  final Color highlightColor;

  const CustomTextButton({
    required this.text,
    required this.onPressed,
    this.width = 156,  // 기본 너비
    this.height = 44,  // 기본 높이
    this.isHighlighted = false, // 기본값 false
    this.highlightColor = defaultHighlightColor, // 기본 하이라이트 색상
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontFamily: 'KoPub Batang',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 1.125, // 텍스트의 줄 높이
      color: Color(0xFF3B3731), // 텍스트 색상
    );

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFF3B3731),
        backgroundColor: Color(0xFFE3DED4),
        side: BorderSide(color: Colors.black, width: 1), // 테두리 색상 및 두께
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 모서리 둥글게
        ),
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16), // 내부 패딩
        minimumSize: Size(width, height), // 버튼의 최소 크기
      ),
      onPressed: onPressed,
      child: isHighlighted
          ? HighLightedText(
        text,
        color: highlightColor,
        textStyle: textStyle, // 스타일 전달
      )
          : Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}