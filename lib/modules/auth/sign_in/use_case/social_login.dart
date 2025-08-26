import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/core/values/login_type.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/sign_in_repo.dart';

class SocialLogin {
  // input la repo
  SignInRepo repo;
  SocialLogin({required this.repo});

  Future<bool?> call(LoginType loginType) async {
    try {
      String token = "";
      if (loginType == LoginType.google) {
        final _LoginWithGoogle loginGoogle = _LoginWithGoogle();
        token = await loginGoogle.getTokenGoogle();
      }
      final res = await repo.loginSocial(token: token);
      return res ?? false;
    } catch (e) {
      throw Exception('Lỗi đăng nhập Google: $e');
    }
  }
}

class _LoginWithGoogle {
  Future<String> getTokenGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return "";
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await auth.signInWithCredential(credential);

    final String? firebaseIdToken = await userCredential.user?.getIdToken();
    return firebaseIdToken ?? "";
  }
}
