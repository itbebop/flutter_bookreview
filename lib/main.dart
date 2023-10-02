import 'package:bookreview/firebase_options.dart';
import 'package:bookreview/src/app.dart';
import 'package:bookreview/src/common/interceptor/custom_interceptor.dart';
import 'package:bookreview/src/common/repository/naver_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // firebase sdk사용할때 native레벨로 상호작용하면서 사용하는 method채널은 widget초기화가 되어야 사용가능하므로 초기화 보장
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // dio쓰면 Request/Response 선처리,후처리를 interceptor로 처리가능함
  Dio dio = Dio(BaseOptions(baseUrl: 'https://openapi.naver.com/'));
  // interceptor 주입 (안하면 401에러)
  dio.interceptors.add(CustomInterceptor());
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;
  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    //return const App();
    // 빈값을 MultiRepositoryProvider로 리턴하면 안됨
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NaverBookRepository(dio),
        )
      ],
      child: const App(),
    );
  }
}
