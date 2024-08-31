import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/circle_button_controller.dart';
import 'package:to_morrow_front/ui/component/speech_bubble.dart';
import '../../repository/controller/maintab_controller.dart';
import '../../repository/controller/sound_write_controller.dart';
import '../../repository/controller/topic_controller.dart';
import '../screens/modal_page/Inspiration_done_modal.dart';

class CircleMenuDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // 다이얼로그 닫기
          },
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        CircleMenu(),
        Positioned(
          bottom: 290,
          child: AnimatedBubbleWidget(comment: '글감을 선택해주세요'),
        ),
      ],
    );
  }
}

// CircleMenu 수정
class CircleMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -14, // 화면 하단보다 -14만큼 아래로 위치
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Color(0xFFE6E2DB),
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFFE7E6E4), width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(300, 300),
              painter: CircleDiagonalLinePainter(),
            ),
            // 원형 버튼들
            Positioned(
              top: 33,
              child: CircleButton(
                imagePath: 'assets/images/title.png',
                label: "제목",
                movePage: 'TitleWritingMaterial',
              ),
            ),
            Positioned(
              bottom: 33,
              child: CircleButton(
                imagePath: 'assets/images/sounds.png',
                label: "소리",
                movePage: 'SoundWrite',
              ),
            ),
            Positioned(
              left: 33,
              child: CircleButton(
                imagePath: 'assets/images/word.png',
                label: "단어",
                movePage: 'WordWritingMaterial',
              ),
            ),
            Positioned(
              right: 33,
              child: CircleButton(
                imagePath: 'assets/images/media.png',
                label: "영상",
                movePage: 'VideoWrite',
              ),
            ),
            // 중앙 아이콘
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF373430),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E2DB),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CircleButton 수정
class CircleButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final String movePage;

  const CircleButton({
    required this.imagePath,
    required this.label,
    required this.movePage,
  });

  @override
  Widget build(BuildContext context) {
    final MainTabController tabController = Get.find();
    final CircleButtonController _controller =
        Get.put(CircleButtonController());

    final SoundWriteController audioController = Get.find();


    return SizedBox(
      height: 56,
      width: 56,
      child: GestureDetector(
        onTap: () {

          if (audioController.isPlaying.value) {
            audioController.stopAudio();
          }

          if (_controller.canWritePoem.value) {
            Navigator.of(context).pop();


            Future.delayed(Duration(milliseconds: 300), ()  async{
              Get.delete<TopicController>(force: true);

              tabController.pageName.value = movePage;
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => (InspirationDoneModal()),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              color: Color(0xff373430),
              width: 24,
              height: 24,
            ),
            SizedBox(height: 4),
            Material(
              type: MaterialType.transparency,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  overflow: TextOverflow.visible,
                  color: Color(0xFF373430),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleDiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0CDC8)
      ..strokeWidth = 1; // 선의 두께

    // 원의 중심
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4;

    final topLeft = Offset(center.dx - radius, center.dy - radius);
    final topRight = Offset(center.dx + radius, center.dy - radius);
    final bottomLeft = Offset(center.dx - radius, center.dy + radius);
    final bottomRight = Offset(center.dx + radius, center.dy + radius);

    canvas.drawLine(topLeft, bottomRight, paint);
    canvas.drawLine(topRight, bottomLeft, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
