import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../repository/controller/dontCommit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserSentimentTagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EmotionAnalysisController emotionController =
        Get.find<EmotionAnalysisController>();

    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/icons/writing_page/to_morrow_sentiment_icon.svg',
                ),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Text(
                    '감정태그를 클릭해서 원하는 감정태그로\n변경하시면 시를 일부분 수정해드립니다.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'KoPubBatangPro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),
            Obx(() {
              if (emotionController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(children: [
                _buildTagRow('테마', emotionController.themes),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                _buildTagRow('상호작용', emotionController.interactions),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ]);
            }),
            Container(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 10),
              child: Center( child :
              Text(
                '니가 어떤 딸인데 그러니',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'KoPubBatangPro',
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Align(
                alignment: Alignment.centerRight,
                  child :
              Text(
                '글 작성자',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'KoPubBatangPro',
                ),
              )),
            ),
        Center( child :
        Container(
          width: 320,
          height: 224,
          padding: EdgeInsets.all(20),
          child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView(
                controller: _scrollController,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Color(0xFFE6E2DB)),
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    child: Text(
                    "가나아다다ㅏㅇ라머ㅣ너라어ㅣㅏ저바러자러저랑너ㅣ라ㅓ지ㅏㅓ라ㅣㅓ라버어 바ㅣ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff373430),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )))),
          ],
        ),
      ),
    );
  }

  Widget _buildTagRow(String title, List<String> apiTags) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            width: 63.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: Color(0xFFD0CDC8),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'KoPub Batang',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF373430),
                ),
              ),
            ),
          ),
          SizedBox(width: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: apiTags.map((tag) {
                final taggedString = tag;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    padding:
                        EdgeInsets.fromLTRB(13, 7 , 6, 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: Color(0xff6D675F)
                      )
                    ),
                    child: Center(
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            taggedString,
                            style: TextStyle(
                              fontFamily: 'KoPub Batang',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF373430),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 14,
                            color: Color(0xff6D675F),
                          ),
                        ],
                      ),

                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}



//태그 바꾸고싶을때
// void _showTagSelectionModal(int tagIndex, List<String> availableTags) {
//   // List<String> wantChangeTags = getTagsCtrl.themes.value; //테마 리스트 전부다
//   // List<String> wantChangeinteractions = getTagsCtrl.interactions.value; //테마 리스트 전부다
//
//
//   // 모달 창 열기 전 현재 선택된 태그 초기화
//   tempSelectedTag = selectedTags[tagIndex];
//   currentTagIndex = tagIndex;
//
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: const Color(0xFFE6E2DB),
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setModalState) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   '변경할 감정태그를 선택해주세요.',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'KoPubBatangPro',
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Expanded(
//                   child: Center(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: availableTags.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         bool isSelected = tempSelectedTag ==
//                             availableTags[index];
//                         return GestureDetector(
//                           onTap: () {
//                             setModalState(() {
//                               tempSelectedTag = availableTags[index];
//                             });
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 12.0),
//                             margin: const EdgeInsets.symmetric(vertical: 4.0),
//                             decoration: BoxDecoration(
//                               color: isSelected ? Colors.brown : Colors
//                                   .transparent,
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 availableTags[index],
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontFamily: 'KoPubBatangPro',
//                                   fontWeight: FontWeight.w400,
//                                   color: isSelected ? Colors.white : Colors
//                                       .black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         '닫기',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'KoPubBatangPro',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (tempSelectedTag != null &&
//                             currentTagIndex != null) {
//                           setState(() {
//                             selectedTags[currentTagIndex!] = tempSelectedTag!;
//                           });
//                         }
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.brown, // 변경 버튼의 배경색 설정
//                       ),
//                       child: const Text(
//                         '변경',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'KoPubBatangPro',
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white, // 변경 버튼의 텍스트 색상
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
