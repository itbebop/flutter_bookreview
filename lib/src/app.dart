import 'package:bookreview/src/temp/detail.dart';
import 'package:bookreview/src/temp/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter router;

  @override
  void initState() {
    // StatefulW으로 한것은 앱 실행시 한번만 실행되는 initState()에 route를 세팅하기 위해서
    super.initState();

    // route
    router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) => const Detail(),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp과 .router의 차이
    // nav 1.0 / nav 2.0 -> go_router를 사용하기 위해서는 2.0이어야함
    return MaterialApp.router(
      routerConfig: router,
      // 아래보다 심플한 방식
      // routerDelegate: router.routerDelegate,
      // routeInformationProvider: router.routeInformationProvider,
      // routeInformationParser: router.routeInformationParser,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xff1C1C1C),
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xff1C1C1C),
      ),
    );
  }
}