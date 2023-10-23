import 'package:bookreview/src/common/model/user_model.dart';
import 'package:bookreview/src/common/repository/authentication_repository.dart';
import 'package:bookreview/src/common/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  // _authenticationRepository를 부모로부터 받아옴
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  AuthenticationCubit(this._authenticationRepository, this._userRepository) : super(const AuthenticationState());

  // stream에서 로그인 상태 변경하는 부분(authentication_repository)을 구독해줌
  // splash에서 auth체크를 할 때 구독할 것
  void init() {
    _authenticationRepository.user.listen((user) {
      _userStateChangedEvent(user);
    });
  }

  void _userStateChangedEvent(UserModel? user) async {
    // db조회를 해야하므로 async
    // 로그아웃 상태
    if (user == null) {
      emit(state.copyWith(status: AuthenticationStatus.unknown));
      // 로그인 상태
    } else {
      var result = await _userRepository.findUserOne(user.uid!); // 로그인된 상태이므로 User의 uid는 반드시 존재함
      if (result == null) {
        // 로그인이 필요한 상태
        emit(state.copyWith(status: AuthenticationStatus.unAthenticated));
      } else {
        emit(
          state.copyWith(
            user: result, // 로그인이 완료되었을 때 상태값(status)와 user정보도 넣어줌
            status: AuthenticationStatus.authentication,
          ),
        );
      }
    }
  }
}

enum AuthenticationStatus {
  authentication,
  unAthenticated,
  unknown,
  error,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel? user;
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown, // 초기값은 unknown
    this.user,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserModel? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user, // user가 없을 때는 기본 user정보를 넣어줌
    );
  }

  @override
  List<Object?> get props => [status, user];
}
