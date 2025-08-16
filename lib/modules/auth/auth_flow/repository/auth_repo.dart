import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/modules/auth/auth_flow/model/login_response.dart';
import 'package:shopping_app/modules/auth/auth_flow/model/register_response.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/auth_local_data_source.dart';

import 'constants.dart';

class AuthRepo {
  final ApiClient apiClient;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepo({required this.apiClient, required this.authLocalDataSource});

  Future<bool> login({required String username, required String password}) async {
    final res = await apiClient.fetch(
      ApiPath.login,
      RequestMethod.post,
      data: {"username": "emilys", "password": "emilyspass", "expiresInMins": 30},
    );
    LoginResponse loginResponse = LoginResponse.fromJson(res.json);
    authLocalDataSource.saveToken(AuthDataConstants.tokenKey);
    print("=====>: ${loginResponse}");
    return res.code == 200;
  }


  Future<bool> register({required String username, required String password,required String email}) async {
     final res = await apiClient.fetch(
      ApiPath.register,
      RequestMethod.post,
      data: {
        "username": username,
        "password": password,
        "email": email,
        "expiresInMins": 30,
      },
    );
     RegisterResponse registerResponse = RegisterResponse.fromJson(res.json);
    print("=====> : ${registerResponse}");
    return res.code == 200;
  }
}
