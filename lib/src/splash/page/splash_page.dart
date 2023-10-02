import 'package:bookreview/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom, // os별로 바닥 높이 다르므로 제일 하단 확인
            left: 0,
            right: 0,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // 어디서부터 어디까진지 설정해야(left,right,bottom)
              children: [
                AppFont(
                  "도서 리뷰 앱으로 \n좋아하는 책을 찾아보세요.",
                  textAlign: TextAlign.center,
                  size: 28,
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(
                  height: 20,
                ),
                AppFont(
                  "데이터 로드 중 입니다.",
                  textAlign: TextAlign.center,
                  size: 13,
                  color: Color(0xff878787),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.white,
                  ),
                ),
                // 가장 밑부터 40 올림
                SizedBox(
                  height: 40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
