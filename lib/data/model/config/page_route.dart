//페이지 정의
import 'package:flutter/cupertino.dart';
import 'package:to_morrow_front/ui/component/emotion_view.dart';
import 'package:to_morrow_front/ui/component/write_edit_view.dart';
import 'package:to_morrow_front/ui/screens/modal_page/EmotionAnalysisModal.dart';

import '../../../ui/screens/main_page/main_home_page.dart';
import '../../../ui/screens/main_page/sound_write.dart';
import '../../../ui/screens/main_page/title_writing_material.dart';
import '../../../ui/screens/main_page/video_write.dart';
import '../../../ui/screens/main_page/word_writing_material.dart';
import '../../../ui/screens/my_page/my_profile.dart';

//이동할 페이지를 정의
Map<String, Widget> pages = {
  'Home': HomePage(),
  'Profile': MyProfile(),
  'TitleWritingMaterial' : TitleWritinMaterial(),
  'VideoWrite' : VideoWrite(),
  'WordWritingMaterial' : WordWritingMaterial(),
  'SoundWrite' : SoundWrite(),
  'Emotion' : EmotionView(),
  'WriteEdit': WriteEditView(),
  'EmotionAnalysisModal' : EmotionAnalysisModal()


};