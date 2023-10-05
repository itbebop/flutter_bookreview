import 'package:hydrated_bloc/hydrated_bloc.dart';

class InnitCubit extends HydratedCubit<bool> {
  // 초기값은 false -> 시작하면 true
  InnitCubit() : super(false);

  void startApp() {
    emit(true);
  }

  @override
  bool fromJson(Map<String, dynamic> json) => json['state'] as bool;

  @override
  Map<String, bool> toJson(bool state) => {'state': state};
}
