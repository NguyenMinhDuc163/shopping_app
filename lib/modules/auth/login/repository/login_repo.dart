import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/data/services/auth_service.dart';
import 'package:shopping_app/modules/auth/login/model/login_social_response.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepo {
  final ApiClient apiClient;
  LoginRepo({required this.apiClient});
  final GoogleSignIn signIn = GoogleSignIn.instance;

  Future signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate(
        scopeHint: ['email'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final String? idToken = userCredential.credential?.accessToken;
      loginSocial(token: idToken ?? "");
      return idToken;


    } catch (e) {
      print("Sign-in error: $e");
      return null;
    }
  }

  Future<bool> loginSocial({required String token}) async {
    final res = await apiClient.fetch(
      ApiPath.loginSocial,
      RequestMethod.post,
      rawData: {"token": token},
    );
    LoginSocialResponse loginSocialResponse = LoginSocialResponse.fromJson(
      res.json,
    );
    final authService = AuthService.instance;
    authService.saveToken(
      accessToken: loginSocialResponse.accessToken ?? "",
      refreshToken: loginSocialResponse.refreshToken ?? "",
    );
    if (res.code != 200) {
      throw res.message;
    }
    return res.code == 200;
  }
}
