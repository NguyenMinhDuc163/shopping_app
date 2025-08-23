import 'package:dio/dio.dart';
import 'package:shopping_app/core/constants/api_path.dart';

class ApiTokenInterceptor extends InterceptorsWrapper {
   final List<String> _apisRequiringToken = [
    '/refresh-token',
    '/auth/login-on-firebase',
    '/auth/register',
    '/products',
    '/auth/verify-otp',
    '/auth/reset-password',
    '/auth/forgot-password',
    '/auth/login-social',
  ];

  bool shouldAddTokenToApi(String path) {
    for (String api in _apisRequiringToken) {
      if (path.contains(api)) {
        return true;
      }
    }
    return false;
  }
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (shouldAddTokenToApi(options.path)) {
      String updatedPath = options.path;
      final String urlToken = ApiPath.registerId;

      if (!updatedPath.contains(urlToken)) {
        updatedPath = '$updatedPath/$urlToken';
      }

      final RequestOptions updatedOptions = options.copyWith(path: updatedPath);
      super.onRequest(updatedOptions, handler);
    } else {
      super.onRequest(options, handler);
    }
  }
}
