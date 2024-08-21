import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../maintab_controller.dart';
import '../../page_fold.dart';
import 'emotion_change_modal.dart';

class ReadWritingPage extends StatefulWidget {
  final String title;
  final String author;
  final String contents;

  ReadWritingPage({
    Key? key,
    required this.title,
    required this.author,
    required this.contents,
  }) : super(key: key);

  @override
  _ReadWritingPageState createState() => _ReadWritingPageState();
}

class _ReadWritingPageState extends State<ReadWritingPage>
    with SingleTickerProviderStateMixin {
  final MainTabController tabController = Get.put(MainTabController());

  bool _isFolded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.16).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleFold() {
    setState(() {
      if (_isFolded) {
        _controller.reverse();
        customSnackBar(context, true);  // 스낵바 표시
      } else {
        _controller.forward();
        customSnackBar(context, false); // 스낵바 표시
      }
      _isFolded = !_isFolded;
    });
  }


  void customSnackBar(BuildContext context, bool isFolded) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.76, // 화면의 2/3 지점
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
              isFolded ? '북마크가 해제 되었습니다' :'북마크가 설정 되었습니다',
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
    return Container(
      color: Color(0xffE6E2DB),
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildEmotionSelector(context),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Text(
                        widget.title,
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
                      '작가이름 ${widget.author}',
                      style: TextStyle(fontSize: 14, color: Color(0xff6D675F)),
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          width: 264,
                          child: Text(
                            widget.contents,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff373430),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          // FoldedCornerContainer
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return FoldedCornerContainer(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                backgroundColor: Colors.transparent,
                cornerColor: Color(0xffE6E2DB),
                foldAmount: _animation.value,
                lineAnimation: _animation.value,
              );
            },
          ),
          // Bookmark icon
          Positioned(
            left: 4,
            bottom: 4,
            child: GestureDetector(
              onTap:_toggleFold,

              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final color = _animation.value > 0.0 ? Colors.black : null;
                  return Image.asset(
                    'assets/images/bookmark.png',
                    width: 21,
                    height: 25,
                    color: color,
                  );
                },
              ),
            ),
          ),
          // Container(
          //   height: 84,
          //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 24),
          //   child: Row(
          //     children: [
          //       Image.asset("assets/images/button_play.png", width: 36,height: 36)
          //     ],
          //   )
          // )
        ],
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
          padding: EdgeInsets.symmetric(vertical: 11),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}