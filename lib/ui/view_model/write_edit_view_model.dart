import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteEditViewModel extends GetxController {
  // 텍스트 정렬 -> 0(기본), 1(가운데), 2(오른쪽)
  var textAlign = 0.obs;
  // 폰트 크기 -> 0(기본), 1(큰), 2(작은)
  var fontSize = 0.obs;
  // 선택된 폰트 패밀리
  var selectedFont = <String, Object>{
    "family": "KoPubBatangPro",
    "weight": FontWeight.w400,
    "name": "KoPub Batang Medium"
  }.obs;

  // 임시 선택된 폰트
  var tempSelectedFont = <String, Object>{}.obs;

  @override
  void onInit() {
    super.onInit();
    tempSelectedFont.value = Map<String, Object>.from(selectedFont);
  }

  // 텍스트 정렬 변경
  void toggleTextAlign() {
    textAlign.value = (textAlign.value + 1) % 3;
  }

  // 폰트 크기 변경
  void toggleFontSize() {
    fontSize.value = (fontSize.value + 1) % 3;
  }

  // 폰트 변경 적용
  void applyFontChange() {
    selectedFont.value = Map<String, Object>.from(tempSelectedFont);
  }

  // 폰트 변경 취소
  void cancelFontChange() {
    tempSelectedFont.value = Map<String, Object>.from(selectedFont);
  }
}
