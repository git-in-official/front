import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/sound_write_controller.dart';

import '../../../repository/controller/bookmark_controller.dart';
import '../../../repository/controller/maintab_controller.dart';
import '../../../repository/controller/play_poem_controller.dart';
import '../../component/page_fold.dart';
import '../../component/speech_bubble.dart';
import '../modal_page/emotion_change_modal.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReadWritingPage extends StatelessWidget {

  final MainTabController tabController = Get.put(MainTabController());
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final PlayPoemController playPoem = Get.put(PlayPoemController()); //낭독횟수 카운팅

  final String title;
  final String author; //작가명
  final String contents;
  final String? textAlign;
  final double? textSize;
  final String? textFont;
  final String? audioUrl;
  final RxBool isScrapped;
  final String id; //시 아이디
  final bool putAnimationWidget;

  ReadWritingPage({
    Key? key,
    required this.title,
    required this.author,
    required this.contents,
    this.textAlign,
    this.textSize,
    this.textFont,
    this.audioUrl,
    required this.isScrapped,
    required this.id,
    required this.putAnimationWidget,
  }) : super(key: key);

  final RxBool _isFolded = false.obs;
  final RxDouble _animationValue = 0.0.obs;

  // AudioPlayer 인스턴스 생성
  final SoundWriteController _audioController = Get.find();

  Future<void> _playPauseAudio() async {
    try {
      if (_audioController.isPlaying.value) {
        await _audioController.player.pause();
      } else {
        await _audioController.player.play(UrlSource(audioUrl!));
        await playPoem.fetchData(id);
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  //북마크 삼각형 접는 부분
  // final RxBool _isFolded = false.obs; -> 접을 껀지 말껀지 false 면 안접어 (북마크아님) / true 면 접어 (북마크)
  // final RxDouble _animationValue = 0.0.obs; -> 0 이면 북마크 아님, 0이상은 북마크임

  void _toggleFold(BuildContext context) {
    if (isScrapped.value == false) {
      customSnackBar(context); // 북마크 해지 되었다 말하기
      _animationValue.value = 0.0; // 북마크 아님
    } else {
      _animationValue.value = 0.16; //북마크임
      customSnackBar(context); // 북마크 처리 되었다.
    }
    // _isFolded.value = !_isFolded.value;
    // isScrapped.value = !isScrapped.value;
  }

  void customSnackBar(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.76,
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Color.fromRGBO(55, 52, 48, 0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              isScrapped.value ? '북마크가 설정 되었습니다' : '북마크가 해제 되었습니다',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 초기화
    _audioController.setupAudioPlayer();
    print(isScrapped.value);
    if (isScrapped.value) {
      _animationValue.value = 0.16;
    } else {
      _animationValue.value = 0.0;
    }

    // 폰트 정보 분리
    final fontParts = _parseFontString(textFont);
    final fontFamily = fontParts['family'] ?? 'KoPubBatangPro';
    final fontWeight = fontParts['weight'] != null
        ? FontWeight.values[int.parse(fontParts['weight']!)]
        : FontWeight.normal;

    return Scaffold(
      backgroundColor: Color(0xffE6E2DB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Color(0xffE6E2DB),
        elevation: 0,
        flexibleSpace: _buildEmotionSelector(context),
      ),
      body: Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: fontFamily ?? 'KoPubBatangPro',
                          fontWeight: fontWeight,
                          color: Color(0xff373430),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      author,
                      style: TextStyle(
                        fontFamily: textFont ?? 'KoPubBatangPro',
                        fontSize: textSize ?? 14,
                          color: Color(0xff6D675F)
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        contents,
                        style: TextStyle(
                          fontFamily: fontFamily ?? 'KoPubBatangPro',
                          fontWeight: fontWeight,
                          fontSize: textSize ?? 14,
                          color: Color(0xff373430),
                        ),
                        textAlign: parseTextAlign(textAlign),
                      ),
                    ),
                  )),
                ],
              ),
            ),



            Obx(() {
              return FoldedCornerContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                backgroundColor: Colors.transparent,
                cornerColor: Color(0xffE6E2DB),
                foldAmount: isScrapped.value
                    ? _animationValue.value = 0.16
                    : _animationValue.value = 0.0,
                lineAnimation: isScrapped.value
                    ? _animationValue.value = 0.16
                    : _animationValue.value = 0.0,
              );
            }),
            Positioned(
              left: 4,
              bottom: 4,
              child: GestureDetector(
                onTap: () {
                  if (isScrapped.value == false) {
                    _animationValue.value = 0.16; // 북마크 아님
                    customSnackBar(context); // 북마크 해지 되었다 말하기
                  } else {
                    _animationValue.value = 0.10; //북마크임
                    customSnackBar(context); // 북마크 처리 되었다.
                  }

                  isScrapped.value = !isScrapped.value;

                  final BookMarkController bookMarkController =
                      Get.put(BookMarkController());
                  bookMarkController.fetchData(id);
                },
                child: Obx(() {
                  final color = isScrapped.value ? Colors.black : null;
                  return Image.asset(
                    'assets/images/bookmark.png',
                    width: 21,
                    height: 25,
                    color: color,
                  );
                }),
              ),
            ),
            Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: audioUrl != null && audioUrl!.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () async {
                            await _playPauseAudio();
                          },
                          child: Obx(() {
                            return Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE6E2DB),
                                border: Border.all(
                                  color: Color(0xFF373430),
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  _audioController.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Color(0xFF373430),
                                  size: 18.0,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 10),
                        // 재생 바
                        Expanded(child: Obx(() {
                          return Slider(
                            value: _audioController.position.value.inSeconds
                                .toDouble(),
                            min: 0.0,
                            max: _audioController.duration.value.inSeconds
                                .toDouble(),
                            onChanged: (value) {
                              _audioController.player
                                  .seek(Duration(seconds: value.toInt()));
                              _audioController.position.value =
                                  Duration(seconds: value.toInt());
                            },
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                          );
                        })),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
                left: 116,
                right: 116,
                child: Visibility(
                    visible: putAnimationWidget == true,
                    child: AnimatedBubbleWidget(
                      comment: '글감을 선택하여 집필해보세요',
                    )))
          ],
        ),
      ),
    );
  }

  // 감정 제목에 따라 이미지 경로를 반환하는 메서드 추가
  String getImagePath(String emotion) {
    switch (emotion) {
      case '기쁨':
        return 'assets/images/icon-happy.png';
      case '슬픔':
        return 'assets/images/icon-sad.png';
      case '두려움':
        return 'assets/images/icon-fear.png';
      case '분노':
        return 'assets/images/icon-anger.png';
      case '기대':
        return 'assets/images/icon-expect.png';
      case '신뢰':
        return 'assets/images/icon-trust.png';
      case '모르겠음':
        return 'assets/images/icon-dontno.png';
      default:
        return 'assets/images/icon-happy.png';
    }
  }

  Widget _buildEmotionSelector(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => EmotionChangeModal(),
        );
      },
      child: Obx(() {
        final selectedEmotion = tabController.selectedEmotion.value;

        final imagePath = selectedEmotion != null
            ? getImagePath(selectedEmotion)
            : 'assets/images/icon-happy.png'; // 기본 이미지

        return Container(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text('감정선택', style: TextStyle(fontSize: 14, fontFamily: 'KoPubBatangPro')  ),
            ],
          ),
        );
      }),
    );
  }
  // 폰트 문자열을 분리하는 함수
  Map<String, String?> _parseFontString(String? fontString) {
    if (fontString == null) return {};
    final parts = fontString.split('-');
    return {
      'family': parts.length > 0 ? parts[0] : null,
      'weight': parts.length > 1 ? parts[1] : null,
      'name': parts.length > 2 ? parts[2] : null,
    };
  }
}

TextAlign parseTextAlign(String? textAlign) {
  switch (textAlign?.toLowerCase()) {
    case 'left':
      return TextAlign.left;
    case 'right':
      return TextAlign.right;
    case 'center':
      return TextAlign.center;
    default:
      return TextAlign.start;
  }
}
