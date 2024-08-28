import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/auth_service.dart';
import 'package:to_morrow_front/repository/controller/emotion_analysis_controller.dart';
import 'package:to_morrow_front/ui/screens/sentiment_analysis_page/sentiment_main_page.dart';
import 'package:to_morrow_front/ui/view_model/write_edit_view_model.dart';

class EmotionAnalysisLoading extends StatefulWidget {
  const EmotionAnalysisLoading({super.key});

  @override
  State<EmotionAnalysisLoading> createState() => _EmotionAnalysisLoadingState();
}

class _EmotionAnalysisLoadingState extends State<EmotionAnalysisLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String userName = '';
  final EmotionAnalysisController emotionController = Get.put(EmotionAnalysisController());
  final WriteEditViewModel writeEditViewModel = Get.find();


  @override
  void initState() {
    super.initState();
    // 애니메이션 초기화
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // 서버에서 이름 가져오기
    AuthService().loadServiceName().then((name) {
      setState(() {
        userName = name ?? '투모로우';
      });
      // 시 태그 분석 요청 보내기
      _analyzePoem();
    });
  }

  Future<void> _analyzePoem() async {
    bool isSuccess = await emotionController.analyzePoem(
      writeEditViewModel.title.value,
      '',
    );

    if (isSuccess) {
      // 요청 완료시 페이지 이동
      Get.to(() => const SentimentMainPage());
    } else {
      // 실패
      print('시 태그 분석에 실패했습니다.');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 132), // 상단과 로고 사이 간격
            Stack(
              alignment: Alignment.center,
              children: [
                // 원형 애니메이션 로고
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CustomPaint(
                    painter: CircularProgressPainter(_animation),
                  ),
                ),
                // 로고 삽입
                SvgPicture.asset(
                  'assets/icons/main_menu/main_menu_icon.svg',
                  width: 28,
                  height: 28,
                ),
              ],
            ),
            const SizedBox(height: 48), // 로고와 텍스트 간격
            Obx(() { // Obx로 ViewModel의 제목이 변경될 때마다 업데이트 되도록 함
              return Text(
                'TO.MORROW가\n'
                    '$userName님이 탈고하신\n'
                    '‘${writeEditViewModel.title.value}’의 마음을\n'
                    '읽어내는 중입니다..', // ViewModel에서 시 제목 불러오기
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'KoPubBatangPro',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF373430),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final Animation<double> animation;

  CircularProgressPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double progress = animation.value;

    // 배경 원 페인터
    Paint backgroundPaint = Paint()
      ..color = const Color(0xFF373430).withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 애니메이션 원 페인터
    Paint paint = Paint()
      ..color = const Color(0xFF373430)
      ..strokeWidth = 2 // 애니메이션 원의 두께를 2로 설정
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2; // 12시 방향에서 시작
    double sweepAngle = 2 * pi * progress; // 시계방향으로 채워짐

    // 배경 원 그리기
    canvas.drawCircle(size.center(Offset.zero), size.width / 2 - 5, backgroundPaint);

    // 애니메이션 원 그리기
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2 - 5),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
