import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/constants.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this.sf);

  final SharedPreferences sf;

  Future<void> saveToken(String token) async {
    await sf.setString(AuthDataConstants.tokenKey, token);
  }

  Future<String?> getToken() async {
    return sf.getString(AuthDataConstants.tokenKey);
  }

  Future<void> deleteToken() async {
    await sf.remove(AuthDataConstants.tokenKey);
  }
}
