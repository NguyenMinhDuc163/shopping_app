import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/modules/auth/auth_flow/model/login_response.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/auth_local_data_source.dart';

class AuthRepo {
  final ApiClient apiClient;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepo({required this.apiClient, required this.authLocalDataSource});

  Future login({required String username, required String password}) async {
    final res = await apiClient.fetch(
      ApiPath.login,
      RequestMethod.post,
      data: {
        "username": "emilys",
        "password": "emilyspass",
        "expiresInMins": 30,
      },
    );
    LoginResponse loginResponse = LoginResponse.fromJson(res.json);
    print("Response from ProductRepo: ${loginResponse}");
  }
}
