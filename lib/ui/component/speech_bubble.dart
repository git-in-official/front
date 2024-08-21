import 'package:flutter/cupertino.dart';


//말풍선 꼬리가 하단의 센터용
class speechBubbleBottomCenter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(15, size.height - 15);
    path.lineTo(
        size.width / 2 - 10, size.height - 15); // 왼쪽 하단 모서리를 10만큼 안쪽으로 이동
    path.lineTo(size.width / 2, size.height - 5); // 중앙 하단 부분을 5만큼 위로 이동
    path.lineTo(
        size.width / 2 + 10, size.height - 15); // 오른쪽 하단 모서리를 10만큼 안쪽으로 이동
    path.lineTo(size.width - 15, size.height - 15);
    path.quadraticBezierTo(
        size.width, size.height - 15, size.width, size.height - 30);
    path.lineTo(size.width, 15);
    path.quadraticBezierTo(size.width, 0, size.width - 15, 0);
    path.lineTo(15, 0);
    path.quadraticBezierTo(0, 0, 0, 15);
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(0, size.height - 15, 15, size.height - 15);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

//말풍선 둥둥 떠다니는것 같으면서 투명도도 조절하는것
class AnimatedBubbleWidget extends StatefulWidget {
  final String comment;

  const AnimatedBubbleWidget({required this.comment});

  @override
  _AnimatedBubbleWidgetState createState() => _AnimatedBubbleWidgetState();
}

class _AnimatedBubbleWidgetState extends State<AnimatedBubbleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // 애니메이션 duration을 더 길게 설정
      vsync: this,
    )..repeat(reverse: true); // 애니메이션 반복

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: bubbleWidget(comment: widget.comment),
    );
  }

  Widget bubbleWidget({
    required String comment,
  }) =>
      ClipPath(
        clipper: speechBubbleBottomCenter(),
        child: Container(
          padding: const EdgeInsets.only(
            top: 10, // top의 말풍선이면 25, bottom이면 10
            left: 12,
            right: 12,
            bottom: 25, // top의 말풍선이면 10, bottom이면 25
          ),
          color: const Color(0xff373430),
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xffE6E2DB),
              fontSize: 10,
            ),
            child: Text(
              comment,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ),
      );
}