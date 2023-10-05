import 'package:flutter_bloc/flutter_bloc.dart';

// 어떤 작업을 하는지 상태값을 관리하는 class
// main에 등록함
class SplashCubit extends Cubit<LoadStatus> {
  SplashCubit() : super(LoadStatus.data_load);

  changeLoadStatus(LoadStatus status) {
    // status를 넣어줌
    emit(status);
  }
}

enum LoadStatus {
  data_load('데이터 로드'),
  auth_check('로그인 체크');

  // 상태 추가할때 이 밑으로 추가해주면 됨
  const LoadStatus(this.message);
  final String message;
}
