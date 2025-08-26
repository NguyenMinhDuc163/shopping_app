import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/data/services/auth_service.dart';
import 'package:shopping_app/modules/auth/login/model/login_social_response.dart';
import 'package:shopping_app/modules/auth/sign_in/model/login_response.dart';


class SignInRepo {
  final ApiClient apiClient;
  final AuthService authService;

  SignInRepo({required this.apiClient, required this.authService});

  Future<void> login({required String username, required String password}) async {
    final res = await apiClient.fetch(
      ApiPath.login,
      RequestMethod.post,
      rawData: {"username":username, "password": password,},
    );
    if(res.code != 200){
      throw res.message;
    }

    LoginResponse loginResponse = LoginResponse.fromJson(res.json);
    authService.saveToken(accessToken: loginResponse.accessToken!, refreshToken: loginResponse.refreshToken!);
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

    if (res.code != 200) {
      throw res.message;
    }
    final authService = AuthService.instance;

    authService.saveToken(
      accessToken: loginSocialResponse.accessToken!,
      refreshToken: loginSocialResponse.refreshToken!,
    );

    return res.code == 200;
  }

  Future<void> logout() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();

      final authService = AuthService.instance;
      authService.invalid();

    } catch (e) {
      throw Exception('Lỗi đăng xuất: $e');
    }
  }

}
