import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


  ReadWritingPage({
    Key? key,


    required this.title,
    required this.author,
    required this.contents,
  }) : super(key: key);

  final RxBool _isFolded = false.obs;
  final RxDouble _animationValue = 0.0.obs;

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




    print('acessToken', );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:    Color(0xffE6E2DB),
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
                      child: Center(
                        child: Container(
                          width: 264,
                          child: Text(
                            contents,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff373430),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                },
                child: Obx(() {
                  final color = _animationValue.value > 0.0 ? Colors.black : null;
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
