import 'package:bookreview/src/app.dart';
import 'package:bookreview/src/common/interceptor/custom_interceptor.dart';
import 'package:bookreview/src/common/model/naver_book_search_option.dart';
import 'package:bookreview/src/common/repository/naver_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
      child: Builder(
        builder: (context) => FutureBuilder(
          future: context.read<NaverBookRepository>().searchBooks(
                const NaverBookSearchOption.init(query: '플러터'),
              ),
          builder: (context, snapshot) {
            // 데이터 갯수 확인
            if (snapshot.hasData) {
              return MaterialApp(
                  home: Center(
                child: Text('${snapshot.data?.items?.length ?? 0}'),
              ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
