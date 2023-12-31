import 'package:bookreview/firebase_options.dart';
import 'package:bookreview/src/app.dart';
import 'package:bookreview/src/common/cubit/app_data_load_cubit.dart';
import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:bookreview/src/common/interceptor/custom_interceptor.dart';
import 'package:bookreview/src/common/repository/authentication_repository.dart';
import 'package:bookreview/src/common/repository/naver_api_repository.dart';
import 'package:bookreview/src/common/repository/user_repository.dart';
import 'package:bookreview/src/init/cubit/init_cubit.dart';
import 'package:bookreview/src/splash/cubit/splash_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // firebase sdk사용할때 native레벨로 상호작용하면서 사용하는 method채널은 widget초기화가 되어야 사용가능하므로 초기화 보장
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
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
    var db = FirebaseFirestore.instance;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NaverBookRepository(dio), // 화면에서 사용할 수 있도록 등록
        ),
        RepositoryProvider(
          create: (context) => AuthenticationRepository(FirebaseAuth.instance), // 화면에서 사용할 수 있도록 등록
        ),
        RepositoryProvider(
          create: (context) => UserRepository(db), // db로 할당받아서 넣은 이유는 위 FirebaseAuth.instance는 여기서만 쓰고, db는 다른 데서도 쓸 수 있으므로
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InnitCubit(),
            lazy: false, // 등록되는 순간 바로 instance 생성하면서 프로세스(loading-> loaded)진행됨
          ),
          BlocProvider(
            create: (context) => AppDataLoadCubit(),
            lazy: false, // 등록되는 순간 바로 instance 생성하면서 프로세스(loading-> loaded)진행됨
          ),
          // SplashCubit은 App쪽에 등록해도 되는데 이앱에서는 main에 해줌
          BlocProvider(create: (context) => SplashCubit()),
          BlocProvider(
            create: (context) => AuthenticationCubit(
              context.read<AuthenticationRepository>(), // 화면에서 사용할 수 있도록 등록
              context.read<UserRepository>(), // 화면에서 사용할 수 있도록 등록
            ),
          )
        ],
        child: const App(),
      ),
    );
  }
}
