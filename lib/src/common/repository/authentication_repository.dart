import 'dart:convert';
import 'dart:math';

import 'package:bookreview/src/common/model/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationRepository {
  // 부모로부터 의존성 주입받음
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

  //logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // google login (https://firebase.flutter.dev/docs/auth/social/)
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

  // apple login (https://firebase.flutter.dev/docs/auth/social/)
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    //return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    await _firebaseAuth.signInWithCredential(oauthCredential);
  }
}
