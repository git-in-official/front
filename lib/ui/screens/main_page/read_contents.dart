import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/controller/bookmark_controller.dart';
import '../../../repository/controller/bookmark_controller.dart';
import '../../../repository/controller/maintab_controller.dart';
import '../../component/page_fold.dart';
import '../modal_page/emotion_change_modal.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReadWritingPage extends StatelessWidget {
  final MainTabController tabController = Get.put(MainTabController());
  final FlutterSecureStorage storage = FlutterSecureStorage();

  final String title;
  final String author;
  final String contents;
  final String? textAlign;
  final double? textSize;
  final String? textFont;
  final String audioUrl;
  final RxBool isScrapped;
  final String id;

  ReadWritingPage({
    Key? key,
    required this.title,
    required this.author,
    required this.contents,
    this.textAlign,
    this.textSize,
    this.textFont,
    required this.audioUrl,
    required this.isScrapped,
    required this.id
  }) : super(key: key);

  final RxBool _isFolded = false.obs;
  final RxDouble _animationValue = 0.0.obs;

  // AudioPlayer 인스턴스 생성
  final AudioPlayer player = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;

  void _setupAudioPlayer() {
    player.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
    });

    player.onPositionChanged.listen((Duration newPosition) {
      position.value = newPosition;
    });

    player.onDurationChanged.listen((Duration newDuration) {
      duration.value = newDuration;
    });
  }

  Future<void> _playPauseAudio() async {
    try {
      if (isPlaying.value) {
        await player.pause();
      } else {
        await player.play(UrlSource(audioUrl!));
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _toggleFold(BuildContext context) {
    if (_isFolded.value) {
      _animationValue.value = 0.0;
      customSnackBar(context, true);
    } else {
      _animationValue.value = 0.16;
      customSnackBar(context, false);
    }
    _isFolded.value = !_isFolded.value;
  }

  void customSnackBar(BuildContext context, bool isFolded) {
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
              isFolded ? '북마크가 해제 되었습니다' : '북마크가 설정 되었습니다',
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
    audioUrl != "없음" ? _setupAudioPlayer() : null;

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
                      style: TextStyle(fontSize: 14, color: Color(0xff6D675F)),
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
            Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: audioUrl != '없음',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        // 재생 버튼 + 일시 중지 버튼
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE6E2DB),
                            border: Border.all(
                              color: Color(0xFF373430),
                              width: 1.0, // Border width
                            ),
                          ),
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isPlaying.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Color(0xFF373430),
                                size: 18.0, // Icon size
                              ),
                              onPressed: _playPauseAudio,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // 재생 바
                        Expanded(child: Obx(() {
                          return Slider(
                            value: position.value.inSeconds.toDouble(),
                            min: 0.0,
                            max: duration.value.inSeconds.toDouble(),
                            onChanged: (value) {
                              player.seek(Duration(seconds: value.toInt()));
                              position.value = Duration(seconds: value.toInt());
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
            Obx(() {
              return FoldedCornerContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                backgroundColor: Colors.transparent,
                cornerColor: Color(0xffE6E2DB),
                foldAmount: _animationValue.value,
                lineAnimation: _animationValue.value,
              );
            }),
            Positioned(
              left: 4,
              bottom: 4,
              child: GestureDetector(
                onTap: () {
                  _toggleFold(context);

                  final BookMarkController   bookMarkController =  Get.put (BookMarkController());
                bookMarkController.fetchData(id);

                  isScrapped.value = !isScrapped.value;
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
          ],
        ),
      ),
    );
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
        final imagePaths = [
          'assets/images/icon-happy.png',
          'assets/images/icon-sad.png',
          'assets/images/icon-fear.png',
          'assets/images/icon-anger.png',
          'assets/images/icon-expect.png',
          'assets/images/icon-trust.png',
          'assets/images/icon-dontno.png',
        ];
        final selectedIndex = tabController.selectedEmotionIndex.value;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
          child: Row(
            children: [
              Image.asset(
                selectedIndex >= 0
                    ? imagePaths[selectedIndex]
                    : 'assets/images/icon-happy.png',
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text('감정선택', style: TextStyle(fontSize: 14)),
            ],
          ),
        );
      }),
    );
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
