import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserSentimentTagPage extends StatefulWidget {
  const UserSentimentTagPage({super.key});

  @override
  _UserSentimentTagPageState createState() => _UserSentimentTagPageState();
}

class _UserSentimentTagPageState extends State<UserSentimentTagPage> {
  // 선택된 태그들을 관리하는 리스트
  List<String> selectedTags = ['내적 갈등', '사랑', '상실', '위로'];

  // 테마 태그 선택 가능한 리스트
  List<String> themeTags = [
    '로맨틱', '우정', '가족', '성장', '희망', '자연', '외로움', '상실', '죽음', '그리움',
    '영적', '성공', '평화', '즐거움', '기쁨', '갈등', '화해', '불확실성', '추악함',
    '좌절', '불의 사랑', '연민'
  ];

  // 상호작용 태그 선택 가능한 리스트
  List<String> interactionTags = [
    '위로', '카타르시스', '감사', '환희', '성찰', '격려', '노스텔지아', '자아비판',
    '연대감', '감성적', '이성적', '의문', '상상력', '축하'
  ];

  // 임시로 선택된 태그를 저장할 변수
  String? tempSelectedTag;
  int? currentTagIndex;

  void _showTagSelectionModal(int tagIndex, List<String> availableTags) {
    // 모달 창 열기 전 현재 선택된 태그 초기화
    tempSelectedTag = selectedTags[tagIndex];
    currentTagIndex = tagIndex;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFE6E2DB),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '변경할 감정태그를 선택해주세요.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'KoPubBatangPro',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: availableTags.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = tempSelectedTag ==
                              availableTags[index];
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                tempSelectedTag = availableTags[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.brown : Colors
                                    .transparent,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  availableTags[index],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'KoPubBatangPro',
                                    fontWeight: FontWeight.w400,
                                    color: isSelected ? Colors.white : Colors
                                        .black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '닫기',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'KoPubBatangPro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (tempSelectedTag != null &&
                              currentTagIndex != null) {
                            setState(() {
                              selectedTags[currentTagIndex!] = tempSelectedTag!;
                            });
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown, // 변경 버튼의 배경색 설정
                        ),
                        child: const Text(
                          '변경',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'KoPubBatangPro',
                            fontWeight: FontWeight.w400,
                            color: Colors.white, // 변경 버튼의 텍스트 색상
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/writing_page/to_morrow_sentiment_icon.svg',
                ),
                const SizedBox(width: 10.0),
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
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),
            _buildTagRow('테마', selectedTags.sublist(0, 2), 0, themeTags),
            const SizedBox(height: 10.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),
            _buildTagRow(
                '상호작용', selectedTags.sublist(2, 4), 2, interactionTags),
            const SizedBox(height: 10.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 22.0),
            Container(
                child: Text('니가 어떤 딸인데 그러니', style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'KoPubBatangPro',),

                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagRow(String title, List<String> tags, int startIndex,
      List<String> availableTags) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(tags.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: OutlinedButton(
                    onPressed: () =>
                        _showTagSelectionModal(
                            startIndex + index, availableTags),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '${tags[index]} >',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'KoPubBatangPro',
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}