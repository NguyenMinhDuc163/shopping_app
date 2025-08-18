import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';

class ForgotPassRepo{
  final ApiClient apiClient;

  ForgotPassRepo({required this.apiClient});

  Future<bool> sendOPT({required String email}) async {
    try{
      final res = await apiClient.fetch(
        ApiPath.register,
        RequestMethod.post,
        rawData: {
          "username": "a1",
          "password": "123456",
          "email": email,
          "verification": "4 digit OTP"
        },
      );
      String status = res.json['status'];
      return status == 'ok';
    }catch (e) {
      print("Error in ForgotPassRepo: $e");
      return false;
    }

  }

}