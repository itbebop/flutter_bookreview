import 'package:bookreview/src/common/components/app_font.dart';
import 'package:bookreview/src/common/cubit/app_data_load_cubit.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:bookreview/src/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocListener -> Bloc간 통신
    return BlocListener<AppDataLoadCubit, AppDataLoadState>(
      // 현재상태가 loaded일때만 조건으로
      listenWhen: (previous, current) => current.status == CommonStateStatus.loaded,
      // auth_check로 상태를 변경해줌
      listener: (context, state) {
        context.read<SplashCubit>().changeLoadStatus(LoadStatus.auth_check);
      },
      child: Scaffold(
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
                  BlocBuilder<SplashCubit, LoadStatus>(builder: (context, state) {
                    return AppFont(
                      "${state.message} 중 입니다.",
                      textAlign: TextAlign.center,
                      size: 13,
                      color: const Color(0xff878787),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.white,
                    ),
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
      ),
    );
  }
}
