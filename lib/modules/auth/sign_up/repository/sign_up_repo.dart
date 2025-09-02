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
      rawData: {
        "username": username,
        "password": password,
        "email": email,
        "verification": "4 digit OTP"
      },
    );
    return res.code == 200;
  }

  Future<bool> checkUserName({required String username}) async {
    final res = await apiClient.fetch(
      ApiPath.checkUserName,
      RequestMethod.post,
      rawData: {
        "username": username,
      },
    );
    return res.code == 200 && res.json["result"] == false;
  }

  Future<bool> checkEmail({required String email}) async {
    final res = await apiClient.fetch(
      ApiPath.checkMail,
      RequestMethod.post,
      rawData: {
        "email": email,
      },
    );
    return res.code == 200 && res.json["result"] == false;
  }
}
