import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/components/btn.dart';
import 'package:bookreview/src/init/cubit/init_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocListener -> Bloc간 통신
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
            left: 40,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // 어디서부터 어디까진지 설정해야(left,right,bottom)
              children: [
                const AppFont(
                  "도서 리뷰 앱으로 \n좋아하는 책을 찾아보세요.",
                  textAlign: TextAlign.center,
                  size: 28,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppFont(
                  "책리뷰에서 솔직하고 통찰력 있는 리뷰를 받아보세요. \n모든 장르의 책에 대한 리뷰를 확인할 수 있습니다.\n(로맨스에서 공상과학까지)",
                  textAlign: TextAlign.center,
                  size: 13,
                  color: Color(0xff878787),
                ),

                const SizedBox(
                  height: 20,
                ),
                Btn(
                  onTab: context.read<InnitCubit>().startApp,
                  text: '시작하기',
                ),
                // 가장 밑부터 40 올림
                const SizedBox(
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
