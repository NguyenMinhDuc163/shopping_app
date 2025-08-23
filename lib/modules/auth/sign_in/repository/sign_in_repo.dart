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

  Future<bool> login({required String username, required String password}) async {
    final res = await apiClient.fetch(
      ApiPath.login,
      RequestMethod.post,
      rawData: {"username":username, "password": password,},
    );
    LoginResponse loginResponse = LoginResponse.fromJson(res.json);
    authService.saveToken(accessToken: loginResponse.accessToken ?? "", refreshToken: loginResponse.refreshToken ?? "");
    if(res.code != 200){
      throw res.message;
    }
    return res.code == 200;
  }

  Future<bool?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      final FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      final String? firebaseIdToken = await userCredential.user?.getIdToken();

      if (firebaseIdToken == null) {
        throw Exception('Không thể lấy Firebase ID token');
      }

      final res = await loginSocial(token: firebaseIdToken);
      return res;
    } catch (e) {
      throw Exception('Lỗi đăng nhập Google: $e');
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

  Future<void> logout() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();

      final authService = AuthService.instance;
      authService.clearToken();

    } catch (e) {
      throw Exception('Lỗi đăng xuất: $e');
    }
  }

}
