import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/app_authentication.dart';
import '../../core/constants/app_constants.dart';
import '../../utils/helpers/system_utils.dart';
import '../api_client.dart';
import '../models/request_response.dart';
import '../models/status_code.dart';
import '../services/auth_service.dart';

class TokenInterceptor extends InterceptorsWrapper {
  TokenInterceptor() : authService = AuthService.instance;

  final AuthService authService;

  int _times = 1;

  Completer? _refreshTokenCompleter;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authorization = options.headers['Authorization'];

    final bool areHeadersHasAccessToken = authorization != null &&
        authService.accessToken != null &&
        authorization.toString().contains(authService.accessToken!);

    bool? hasRefreshSucceeded;
    bool hasRefreshFailed = false;

    if (!authService.isRefreshTokenRequest(options)) {
      await _refreshTokenCompleter?.future.catchError((err) {
        _refreshTokenCompleter = null;
      });

      await authService.refreshTokenIfNeeded(
        onPerform: () => _refreshTokenCompleter = Completer(),
        onComplete: () {
          _refreshTokenCompleter?.complete();
          _refreshTokenCompleter = null;

          hasRefreshSucceeded = true;
        },
        onCompleteError: (e) {
          if (_refreshTokenCompleter?.isCompleted == false) {
            _refreshTokenCompleter?.completeError(e, StackTrace.current);
            _refreshTokenCompleter = null;
          }

          hasRefreshFailed = true;
          if (e is DioException) {
            int? statusCode = e.response?.statusCode;

            late Object? error = e.error;

            if (statusCode == null && error is DioException) {
              statusCode = error.response?.statusCode;
            }

            if (statusCode == StatusCode.locked) {
              AppAuthenticationBinding.instance!.notifyLocked();
              return;
            }

            if (statusCode == StatusCode.unauthorized) {
              AppAuthenticationBinding.instance!.notifyRefershTokenExpired();
              return;
            }
          }

          if (areHeadersHasAccessToken) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: e,
                stackTrace: StackTrace.current,
              ),
              true,
            );
          }
        },
      );
    }

    if (hasRefreshFailed && areHeadersHasAccessToken) return;

    final RequestOptions updatedOptions = hasRefreshSucceeded ==
                null /* means it unset */ ||
            !areHeadersHasAccessToken
        ? options
        : options.copyWith(
            headers: {
              ...options.headers,
              if (areHeadersHasAccessToken)
                'Authorization': ApiClient.buildBearerAuthorizationHeaderValue(
                  authService.accessToken!,
                ),
            },
          );

    super.onRequest(updatedOptions, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (authService.isRefreshTokenResponse(response)) {
      super.onResponse(response, handler);
      return;
    }

    final res = await RequestResponse.fromDioResponse(response);
    if (res.error?.code == 10003 && _times <= AppConst.refetchApiThreshold) {
      if (_refreshTokenCompleter != null) {
        await _refreshTokenCompleter?.future.catchError((err) {
          _refreshTokenCompleter = null;
        });
      } else {
        _refreshTokenCompleter = Completer();
        try {
          _times++;
          SystemUtils.debugLog('TokenInterceptor', _times.toString());
          await authService.performRefreshToken();

          _refreshTokenCompleter?.complete();
          _refreshTokenCompleter = null;
        } catch (e) {
          _refreshTokenCompleter?.completeError(e, StackTrace.current);
          _refreshTokenCompleter = null;

          handler.reject(DioException(
            requestOptions: response.requestOptions,
            error: e,
          ));
          return;
        }
      }

      handler.resolve(
        await ApiClient().fetchWithRequestOptions(
          response.requestOptions,
          token: authService.accessToken,
        ),
      );
      _times = 1;
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == StatusCode.locked) {
      AppAuthenticationBinding.instance!.notifyLocked();
    }

    if (authService.isRefreshTokenErrorResponse(err.requestOptions)) {
      super.onError(err, handler);
      return;
    }

    int? statusCode = err.response?.statusCode;

    late Object? error = err.error;

    if (statusCode == null && error is DioException) {
      statusCode = error.response?.statusCode;
    }

    if (statusCode == StatusCode.unauthorized) {
      AppAuthenticationBinding.instance!.notifyRefershTokenExpired();
      return;
    }

    if (statusCode == StatusCode.unauthorized &&
        _times <= AppConst.refetchApiThreshold) {
      if (_refreshTokenCompleter != null) {
        await _refreshTokenCompleter?.future.catchError((err) {
          _refreshTokenCompleter = null;
        });
      } else {
        try {
          _times++;
          SystemUtils.debugLog('TokenInterceptor', _times.toString());
          await authService.performRefreshToken();

          _refreshTokenCompleter?.complete();
          _refreshTokenCompleter = null;
        } catch (e) {
          _refreshTokenCompleter?.completeError(e, StackTrace.current);
          _refreshTokenCompleter = null;

          final RequestOptions requestOptions;

          if (e is DioException) {
            requestOptions = e.requestOptions;
          } else {
            requestOptions = err.requestOptions;
          }

          handler.reject(DioException(
            requestOptions: requestOptions,
            error: e,
          ));
          return;
        }
      }

      handler.resolve(
        await ApiClient().fetchWithRequestOptions(
          err.requestOptions,
          token: authService.accessToken,
        ),
      );
      _times = 1;
    } else {
      if (_times > AppConst.refetchApiThreshold) {
        _times = 1;
        handler.resolve(Response(
          requestOptions: err.requestOptions..data = err.response,
        ));
        authService.notifyTokenChanged();
      } else {
        _times = 1;
        super.onError(err, handler);
      }
    }
  }
}
