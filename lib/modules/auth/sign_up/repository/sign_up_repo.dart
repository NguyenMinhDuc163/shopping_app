import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/modules/auth/sign_in/model/register_response.dart';


class SignUpRepo {
  final ApiClient apiClient;

  SignUpRepo({required this.apiClient});


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
