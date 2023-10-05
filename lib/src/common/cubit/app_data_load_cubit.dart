import 'package:bloc/bloc.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:equatable/equatable.dart';

// 데이터를 받는 것처럼 꾸며줌
class AppDataLoadCubit extends Cubit<AppDataLoadState> {
  AppDataLoadCubit() : super(const AppDataLoadState()) {
    // cubit이 context에 등록되는 순간 데이터 로드할 수 있도록
    _loadData();
  }
  void _loadData() async {
    emit(state.copyWith(status: CommonStateStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(state.copyWith(status: CommonStateStatus.loaded));
  }
}

class AppDataLoadState extends Equatable {
  final CommonStateStatus status;
  // 초기값으로 init상태를 갖도록 함
  const AppDataLoadState({this.status = CommonStateStatus.init});
  AppDataLoadState copyWith({
    CommonStateStatus? status,
  }) {
    return AppDataLoadState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
