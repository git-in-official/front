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
  final bool hasIcon; // 아이콘 표시 여부
  final Icon? icon; // 표시할 아이콘

  const CustomTextButton({
    required this.text,
    required this.onPressed,
    this.width = 152,  // CSS에서 width는 152px
    this.height = 44,  // CSS에서 height는 44px
    this.isHighlighted = false, // 기본값 false
    this.highlightColor = defaultHighlightColor, // 기본 하이라이트 색상
    this.hasIcon = false, // 기본값 false
    this.icon, // 기본값 null
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontFamily: 'KoPub Batang',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 1.125, // CSS의 line-height와 동일
      color: Color(0xFF3B3731), // 버튼 텍스트 색상
    );

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFF3B3731),
        backgroundColor: Color(0xFFE3DED4),
        side: BorderSide(color: Color(0xFF373430), width: 1), // 테두리 색상 및 두께
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 모서리 둥글게
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // 내부 패딩
        minimumSize: Size(width, height), // 버튼의 최소 크기
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasIcon && icon != null) ...[
            icon!,
            SizedBox(width: 4), // 아이콘과 텍스트 사이의 간격 (4px)
          ],
          isHighlighted
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
        ],
      ),
    );
  }
}
