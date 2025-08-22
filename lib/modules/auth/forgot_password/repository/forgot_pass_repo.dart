import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';

class ForgotPassRepo {
  final ApiClient apiClient;

  ForgotPassRepo({required this.apiClient});

  Future<bool> sendOPT({required String username}) async {
    final res = await apiClient.fetch(
      ApiPath.forgotPassword,
      RequestMethod.post,
      rawData: {
        "username": username,
        "verification": "4 digit OTP",
      },
    );
    String status = res.json['status'];
    return status == 'ok' && res.code == 200;
  }



  Future<bool> verifyOtp({required String otp, required String userName}) async {
    final res = await apiClient.fetch(
      ApiPath.verifyOtp,
      RequestMethod.post,
      rawData: {"username": userName, "enteredOtp": otp, "expiresInMins": 30},
    );
    return res.code == 200;
  }

  Future<bool> resetPassword({required String userName, required String password}) async {
    final res = await apiClient.fetch(
      ApiPath.resetPassword,
      RequestMethod.post,
      rawData: {"username": userName, "password": password},
    );
    String status = res.json['status'];
    return status == 'ok';
  }
}
