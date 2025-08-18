import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/modules/auth/sign_in/model/login_response.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/auth_local_data_source.dart';

import 'constants.dart';

class SignInRepo {
  final ApiClient apiClient;
  final AuthLocalDataSource authLocalDataSource;

  SignInRepo({required this.apiClient, required this.authLocalDataSource});

  Future<bool> login({required String username, required String password}) async {
    final res = await apiClient.fetch(
      ApiPath.login,
      RequestMethod.post,
      rawData: {"username":username, "password": password,},
    );
    LoginResponse loginResponse = LoginResponse.fromJson(res.json);
    authLocalDataSource.saveToken(AuthDataConstants.tokenKey);
    print("=====>: ${loginResponse}");
    return res.code == 200;
  }

}
