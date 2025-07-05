
import 'package:shopping_app/core/constants/app_constants.dart';

class Validators {
  static String? isBlank(
    String? value,
    String msg, [
    bool autoToLowerCase = true,
  ]) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập ${autoToLowerCase ? msg.toLowerCase() : msg}";
    }

    return null;
  }

  static String? isLength(
    String? value, [
    int minimumLength = 50,
  ]) {
    final int count =
        value == null ? 0 : value.split(AppConst.Pattern.nonWord).length;

    if (count < minimumLength) {
      return "Bạn phải nhập ít nhất $minimumLength từ (đã nhập $count/$minimumLength từ)";
    }

    return null;
  }

  static bool isValidEmail(String email) {
    return AppConst.Pattern.email.hasMatch(email);
  }

  static String? isValidEmailNotification(
    String? value, {
    required bool isOptional,
  }) {
    if (value == null || value.isEmpty) {
      if (isOptional) {
        return null;
      }

      return 'Email không được để trống';
    }

    if (isValidEmail(value)) return null;

    return 'Email không đúng định dạng';
  }

  static String? _isValidPassword(String password) {
    if (password.length < AppConst.minPasswordLength) {
      return "Mật khẩu phải phải nhiều hơn ${AppConst.minPasswordLength - 1} ký tự";
    }

    return null;
  }

  static String? isValidPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }

    return _isValidPassword(value);
  }
}
