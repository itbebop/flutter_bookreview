import 'package:bookreview/src/init/cubit/init_cubit.dart';
import 'package:bookreview/src/init/page/init_page.dart';
import 'package:bookreview/src/splash/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 초기페이지인지 스플레시인지 분기를 태워주는 클래스
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InnitCubit, bool>(builder: (context, state) {
      return state ? const SplashPage() : const InitPage();
    });
  }
}
