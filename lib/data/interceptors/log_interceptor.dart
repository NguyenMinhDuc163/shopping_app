import 'package:dio/dio.dart';

import '../../utils/helpers/system_utils.dart';

const _source = 'LogInterceptor';

class LogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    SystemUtils.debugLog(
      _source,
      '''
      URL: ${options.path}
      Method: ${options.method}
      header: ${options.headers}
      body/query: ${options.data}
    ''',
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    SystemUtils.debugLog(
      _source,
      '''
      Error: $err
      Error response: ${err.response}
      URL: ${err.requestOptions.path}
    ''',
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    SystemUtils.debugLog(
      _source,
      '''
      Response: ${response.requestOptions.path}
      $response
    ''',
    );
  }
}
