import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDesignation extends StatelessWidget {
  const MyDesignation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E2DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E2DB),
         titleSpacing: 16,
        // leadingWidth: 40.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
                  '업적',
                  style: TextStyle(
                    fontFamily: 'KoPubBatangPro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
          ],
        ),
        bottom: PreferredSize(
          // 칭호 밑에 회색 선
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFBDBDBD),
            height: 1.0,
          ),
        ),
      ),
      body: const MyRepresentativeBadge(),
    );
  }
}

class MyRepresentativeBadge extends StatelessWidget {
  const MyRepresentativeBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text(
            '나의 대표 배지',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFD0CDC8),
                  shape: BoxShape.circle,
                ),
              ),
              const Icon(
                Icons.lock,
                size: 32,
                color: Color(0xFF6D675F),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width, // 디바이스의 전체 너비를 차지하도록 설정
            height: 1.0,
            color: const Color(0xFFBDBDBD), // 선 색상 설정
          ),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(40.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 한 행에 3개의 아이템 배치
                crossAxisSpacing: 32.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: 9, // 자물쇠 아이콘 개수
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFD0CDC8),
                    ),
                    const Icon(
                      Icons.lock,
                      size: 32,
                      color: Color(0xFF6D675F),
                    ),
                    if (index == 0)
                      Positioned(
                        top: -10,
                        left: -10,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
