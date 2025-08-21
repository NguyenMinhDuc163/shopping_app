import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/data/services/auth_service.dart';
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

}
