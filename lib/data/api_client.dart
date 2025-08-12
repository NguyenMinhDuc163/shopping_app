import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core/constants/api_path.dart';
import '../core/constants/app_constants.dart';
import '../core/error_handling/exceptions.dart';
import '../utils/helpers/system_utils.dart';
import 'interceptors/token_interceptor.dart';
import 'models/request_method.dart';
import 'models/request_response.dart';
import 'models/status_code.dart';
import 'services/connectivity_service.dart';

/*
enum ParameterArrayFormat {
  /// Multiple parameter instances rather than multiple values.
  /// e.g. (foo=value&foo=another_value)
  multipleInstances(ListFormat.multi),

  /// Multiple parameters with the same name.
  /// e.g. (foo[]=value&foo[]=another_value)
  bracketsPostfix(ListFormat.multiCompatible);

  final ListFormat _dioFormat;

  const ParameterArrayFormat(this._dioFormat);
}
*/

/// Use [JsonEncoder] instead of [jsonEncode] to specify the indentation
const JsonEncoder _jsonEncoder = JsonEncoder.withIndent('  ');

String _prettyJson(Object? object) {
  final result = _jsonEncoder.convert(object);
  if (result.startsWith('{')) {
    return "\n$result";
  }
  return result;
}

const _exceptionCanResolveByReFetch = [
  'HttpException: Connection closed before full header was received',
  'HandshakeException: Connection terminated during handshake',
  'Connecting timed out',
  'Receiving data timeout',
];

bool _shouldReFetch(DioException e, int retryTimes) {
  return _exceptionCanResolveByReFetch.any((el) => e.message?.contains(el) == true) &&
      retryTimes <= AppConst.refetchApiThreshold;
}

final String _debugEmptyResponse = SystemUtils.colorizeTerminalText.cyan('<Empty>');

final _baseOptions = BaseOptions(
  connectTimeout: const Duration(milliseconds: 100000),
  receiveTimeout: const Duration(milliseconds: 100000),
  baseUrl: ApiPath.baseUrl,
  responseType: ResponseType.json,
);

class ApiClient {
  late final Dio _dio;

  static ApiClient? _instance;

  factory ApiClient() => _instance ??= ApiClient._();

  ApiClient._()
      : _dio = Dio(_baseOptions)
          ..interceptors.addAll([
            // LogInterceptor(),
            CurlLoggerDioInterceptor(
              printOnSuccess: true,
              convertFormData: true,
            ),
            TokenInterceptor(),
          ]);

  static String buildBearerAuthorizationHeaderValue(String token) {
    return 'Bearer $token';
  }

  /// [Eng]
  ///
  /// [asyncDataGetter]
  ///
  /// Used to avoid some cases (below) when the data containing [MultipartFile]
  ///
  ///   - Bad network ⇒ retry calling API, but Dio throws:
  /// `Bad state: Can't finalize a finalized MultipartFile`
  ///
  ///   - After running `Hot Reload`
  ///
  /// [token] (bearer tokens) will be put in `Authorization` header if
  /// [headers] did not contain `Authorization`
  ///
  /// See: Bearer Authentication (token authentication)
  ///
  /// ---
  ///
  /// [Vie]
  ///
  /// [asyncDataGetter] dùng trong trường hợp dữ liệu được gửi lên server
  /// bao gồm [MultipartFile]
  ///
  /// Tác dụng: Tránh 1 số tình trạng như
  ///
  ///   - Mạng kém ⇒ phải gọi lại api 1 lần nữa, nhưng lại xảy ra lỗi:
  /// `Bad state: Can't finalize a finalized MultipartFile`
  ///
  ///   - Sau khi chạy `Hot Reload`
  ///
  /// [token] (bearer tokens) sẽ được đặt vào trong `Authorization` header
  /// nếu như [headers] không có `Authorization`
  ///
  /// Xem: Bearer Authentication (token authentication)
  Future<RequestResponse> fetch(
    final String url,
    final RequestMethod method, {
    final Map<String, dynamic>? data,
    final Map<String, dynamic>? rawData,
    final Future<Map<String, dynamic>> Function()? asyncDataGetter,
    final Future<Map<String, dynamic>> Function()? asyncRawDataGetter,
    final Map<String, String>? searchParams,
    Map<String, dynamic>? headers,
    Options? options,
    final String? token,
    final bool isBearerToken = true,
    final bool debugLogResponse = false,
  }) async {
    assert(
      data == null || asyncDataGetter == null,
      '[Eng] Only using [data] or [asyncDataGetter]\n'
      '[Vie] Chỉ dùng 1 trong 2 trường [data] hoặc [asyncDataGetter]',
    );

    headers ??= HashMap();

    if (options == null) {
      options = method.options;
    } else {
      options.method = method.name;
    }

    if (token != null) {
      headers.putIfAbsent(
        'Authorization',
        () => !isBearerToken ? token : buildBearerAuthorizationHeaderValue(token),
      );
    }

    options.headers = headers;
    options.contentType ??= headers.containsKey('Authorization')
        ? ContentType('application', 'x-www-form-urlencoded', charset: "utf-8").mimeType
        : ContentType.json.mimeType;

    Response response;
    int retryTimes = 1;

    String? debugUrl;
    assert(() {
      debugUrl = SystemUtils.debugLog.colorizeSource(
        url,
        TerminalTextColor.yellow,
      );
      return true;
    }());

    while (true) {
      try {
        final Map<String, dynamic>? effectiveData = data ?? await asyncDataGetter?.call();

        response = await _dio.request(
          url,
          data: rawData ??
              await asyncRawDataGetter?.call() ??
              (method == RequestMethod.post && effectiveData != null ? FormData.fromMap(effectiveData) : effectiveData),
          queryParameters: searchParams,
          options: options,
        );

        break;
      } on DioException catch (e) {
        if (kDebugMode) {
          log(e.toString(), name: 'ApiClient', stackTrace: StackTrace.current);
        }

        if (e.response?.statusCode == StatusCode.locked) {
          throw RequestedResourceLockedException(e.response);
        }

        // if (e.response?.statusCode == StatusCode.unauthorized) {
        //   throw RequestedResourceRequireAuthorizationException(e.response);
        // }

        if (_shouldReFetch(e, retryTimes)) {
          retryTimes++;
          continue;
        }

        assert(() {
          if (debugLogResponse) {
            final String debugStatusCode = SystemUtils.debugLog.colorizeSource(
              e.response?.statusCode.toString() ?? '',
              TerminalTextColor.red,
            );

            SystemUtils.debugLog.error(
              'Response $debugStatusCode (error) of $debugUrl',
              e.response?.data == null ? _debugEmptyResponse : _prettyJson(e.response?.data),
            );
          }
          return true;
        }());

        throw await _requestFailure(e, retryTimes);
      }
    }

    assert(() {
      if (debugLogResponse) {
        final String debugStatusCode = SystemUtils.debugLog.colorizeSource(
          response.statusCode.toString(),
          TerminalTextColor.white,
        );

        SystemUtils.debugLog.info(
          'Response $debugStatusCode of $debugUrl',
          response.data == null ? _debugEmptyResponse : _prettyJson(response.data),
        );
      }

      return true;
    }());

    return RequestResponse.fromDioResponse(response);
  }

  /// [Eng]
  ///
  /// If `Authorization` header not null, [token] (bearer tokens)
  /// will override if it existing.
  ///
  /// See: Bearer Authentication (token authentication)
  ///
  /// ---
  ///
  /// [Vie]
  ///
  /// `Authorization` header sẽ bị ghi đè nếu có [token] (bearer tokens).
  ///
  /// Xem: Bearer Authentication (token authentication)
  Future<Response> fetchWithRequestOptions(
    RequestOptions options, {
    String? token,
  }) {
    return _dio.request(
      options.path,
      data: options.data,
      options: Options(
        method: options.method,
        headers: {
          ...options.headers,
          if (token != null) 'Authorization': "Bearer $token",
        },
      ),
    );
  }

  /// [Eng]
  ///
  /// [savePath] is the path to the folder (e.g `library/download/`) + the name
  /// of the file (e.g `xs.jpg`)
  ///
  /// ---
  ///
  /// [Vie]
  ///
  /// [savePath] là đường dẫn tới thư mục (ví dụ `library/download/`) + tên
  /// của file sẽ được tạo ra (ví dụ `xs.jpg`)
  Future<dynamic> download({
    required final String url,
    final String? savePath,
    final FutureOr<String> Function(Headers headers)? savePathBuilder,
    final ProgressCallback? onReceiveProgress,
  }) async {
    assert(
      savePathBuilder == null || savePath == null,
      '[Eng] Only using [savePathBuilder] or [savePath]\n'
      '[Vie] Chỉ dùng 1 trong 2 trường [savePathBuilder] hoặc [savePath]',
    );

    Response response;
    int retryTimes = 1;

    while (true) {
      try {
        response = await _dio.download(
          url,
          savePathBuilder ?? savePath!,
          onReceiveProgress: onReceiveProgress,
        );

        break;
      } on DioException catch (e) {
        if (_shouldReFetch(e, retryTimes)) {
          retryTimes++;
          continue;
        }

        throw await _requestFailure(e, retryTimes);
      }
    }

    return response.data;
  }

  /// [Eng]
  ///
  /// If [isListLiteral] is true, the upload key eventually becomes `files[]`.
  /// This is because many back-end services add a middle bracket to key
  /// when they get an array of files. If you don't want a list literal,
  /// you should set it to false.
  ///
  /// [paramName] is the name of param (e.g `files`)
  ///
  /// ---
  ///
  /// [Vie]
  ///
  /// Nếu để tham số [isListLiteral] là true, param mà back-end nhận được
  /// sẽ là `files[]`. Do nhiều bên back-end thêm dấu ngoặc vuông vào khi nhận
  /// được một danh sách/list các file. Để bỏ dấu ngoặc vuông, truyền false
  /// cho tham số này.
  ///
  /// [paramName] là tên của param (ví dụ `files`)
  Future<dynamic> upload({
    required final String url,
    required final bool isListLiteral,
    required final String paramName,
    required final Iterable<File> files,
  }) async {
    Response response;
    int retryTimes = 1;

    while (true) {
      try {
        final List<MultipartFile> multipartFiles = [];

        for (final file in files) {
          multipartFiles.add(await MultipartFile.fromFile(file.path));
        }

        final FormData formData;

        if (isListLiteral) {
          formData = FormData.fromMap({
            paramName: multipartFiles,
          });
        } else {
          formData = FormData();
          formData.files.addAll(
            multipartFiles.map((e) => MapEntry(paramName, e)),
          );
        }

        response = await _dio.request(
          url,
          data: formData,
          options: RequestMethod.post.options,
        );

        break;
      } on DioException catch (e) {
        if (_shouldReFetch(e, retryTimes)) {
          retryTimes++;
          continue;
        }

        throw await _requestFailure(e, retryTimes);
      }
    }

    return response.data;
  }

  Future<dynamic> _requestFailure(DioException e, int retryTimes) async {
    final dioError = e.error;

    const connectionFailures = [
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.sendTimeout,
    ];
    if (connectionFailures.contains(e.type)) {
      return const ServerConnectionFailureException();
    }

    if (e.message?.contains('Failed host lookup') == true ||
        (dioError is SocketException && dioError.message.contains('Failed host lookup') == true)) {
      if ((await ConnectivityService.canConnectToNetwork()) == false) {
        return const NoConnectionException();
      } else {
        return const InternalServerErrorException();
      }
    }

    if (e.response?.statusCode == StatusCode.notFound) {
      return RequestedResourceNotFoundException();
    }

    if (retryTimes == AppConst.refetchApiThreshold) {
      return const PoorConnectionException();
    }

    return e;
  }
}
