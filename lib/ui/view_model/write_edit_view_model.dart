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

  // 사용자 이름을 관리할 변수

  var userName = ''.obs;

  // 제목 저장 변수
  var title = ''.obs;

  // 본문 내용 저장 변수
  var bodyContent = ''.obs;

  // 원본 내용
  var originalContent = ''.obs;

  // 원본 제목
  var originalTitle = ''.obs;

  // 영감 ID
  var inspirationId = ''.obs;

  // 오디오 파일
  var audioFile = ''.obs;

  // 테마 리스트
  var themes = <String>[].obs;

  // 사용자 인터랙션 리스트
  var interactions = <String>[].obs;

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

  // 제목 업데이트
  void updateTitle(String newTitle) {
    title.value = newTitle;
  }

  // 본문 내용 업데이트
  void updateBodyContent(String newContent) {
    bodyContent.value = newContent;
  }

  // 원본 내용 업데이트
  void updateOriginalContent(String newOriginalContent) {
    originalContent.value = newOriginalContent;
  }

  // 원본 제목 업데이트
  void updateOriginalTitle(String newOriginalTitle) {
    originalTitle.value = newOriginalTitle;
  }

  // 영감 ID 업데이트
  void updateInspirationId(String newInspirationId) {
    inspirationId.value = newInspirationId;
  }

  // 오디오 파일 업데이트
  void updateAudioFile(String newAudioFile) {
    audioFile.value = newAudioFile;
  }

  // 테마 추가
  void addTheme(String theme) {
    themes.add(theme);
  }

  // 테마 제거
  void removeTheme(String theme) {
    themes.remove(theme);
  }

  // 인터랙션 추가
  void addInteraction(String interaction) {
    interactions.add(interaction);
  }

  // 인터랙션 제거
  void removeInteraction(String interaction) {
    interactions.remove(interaction);
  }

  // 값 초기화
  void resetValues() {
    textAlign.value = 0;
    fontSize.value = 0;
    selectedFont.value = {
      "family": "KoPubBatangPro",
      "weight": FontWeight.w400,
      "name": "KoPub Batang Medium"
    };
    bodyContent.value = '';
    /*inspirationId.value = '';
    audioFile.value = '';
    themes.clear();
    interactions.clear();*/
  }

}
