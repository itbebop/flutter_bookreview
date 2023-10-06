import 'package:bookreview/src/common/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  AuthenticationRepository(this._firebaseAuth);

  // user가 아니라 새로 만든 userModel을 이용하여 작업해주기 위해서 stream을 새로 만듬
  Stream<UserModel?> get user {
    // login할 떄마다 user객체가 오는 것이 아니고 user모델이 컨버트되어 사용가능한 상태가 될 것임
    return _firebaseAuth.authStateChanges().map<UserModel?>((user) {
      return user == null
          ? null
          : UserModel(
              name: user.displayName,
              uid: user.uid,
              email: user.email,
            );
    });
  }

  // 이 함수를 호출하면 구글 로그인됨
  // 여기서 완료되면 위의 Stream<UserModel?> get user로 감
  // 화면에서 Stream.. 을 구독하고 있으면 화면처리를 해줄 수 있는 것
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // 화면에서 처리를 해줄 게 아니므로 리턴 필요없음
    // 위에서도 _firebaseAuth로 받아서 쓰므로 여기도 변경해줌
    //return await FirebaseAuth.instance.signInWithCredential(credential);
    await _firebaseAuth.signInWithCredential(credential);
  }
}
