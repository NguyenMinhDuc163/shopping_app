import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_app/utils/helpers/json_ext.dart';
import 'package:sp_util/sp_util.dart';

import '../../common/app_status.dart';
import '../../core/app_authentication.dart';
import '../../core/constants/api_path.dart';
import '../api_client.dart';
import '../models/request_method.dart';
import '../secure_storage.dart';

const String _accessTokenKey = 'access-token';
const String _refreshTokenKey = 'refresh-token';
const String _tokenExpiresTimeKey = 'expires_in';
const String _isUserBlockedKey = 'is_user_blocked';

/// Store all keys will be eliminated
const _keysToEliminate = [
  _accessTokenKey,
  _refreshTokenKey,
  _tokenExpiresTimeKey,
  _isUserBlockedKey,
];

final class AuthService {
  late final SecureStorage _secureStorage;

  static AuthService? _instance;
  static AuthService get instance => _instance!;

  static Future<AuthService> initialize() async {
    final instance = _instance ??= AuthService._();

    // Clear iOS Keychain after reinstall
    // (the app is starting for the first time after an uninstall)
    if (AppStatus.isFirstTimeAppLaunch && Platform.isIOS) {
      for (final key in _keysToEliminate) {
        await instance._secureStorage.delete(key);
      }
    }

    await instance._loadToken();

    return instance;
  }

  AuthService._() {
    AppAuthenticationBinding.initInstance();
    _secureStorage = SecureStorage();
    setIsUserBloceked(false);
  }

  String? _accessToken;
  String? get accessToken => _accessToken;

  bool get isUserBlocked => SpUtil.getBool(_isUserBlockedKey) ?? false;

  String? _refreshToken;

  /// It's a specific date time, not a period of time
  int? _tokenExpiresTime;

  @visibleForTesting
  String? get refreshToken => _refreshToken;

  bool _isRefreshTokenInvalid = false;

  Completer? _refreshTokenCompleter;

  Future<void> _loadToken() async {
    _accessToken = await _secureStorage.read(_accessTokenKey);
    final String? rawTokenExpiresTime = await _secureStorage.read(_tokenExpiresTimeKey);
    _tokenExpiresTime = rawTokenExpiresTime == null ? null : int.tryParse(rawTokenExpiresTime);
    _refreshToken = await _secureStorage.read(_refreshTokenKey);
  }

  Future<void> saveToken({
    required String accessToken,
    required String refreshToken,
    int? tokenExpiresTime,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);

    if (tokenExpiresTime != null) await saveExpiresTime(tokenExpiresTime);

    log('Access Token đã được lưu vào là: $_accessToken', name: 'AuthService');
  }

  static Future<void> setIsUserBloceked(bool isBlock) async {
    await SpUtil.getInstance();
    await SpUtil.putBool(_isUserBlockedKey, isBlock);
  }

  @visibleForTesting
  Future<void> saveAccessToken(String token) async {
    _accessToken = token;
    /*
    Saut.toPage(
      Saut.navigator.context,
      AppPages.NonDismissibleCupertinoAlertDialog,
      arguments: {
        'previousPageContext': Saut.navigator.context,
        'widget': DebugDialog(
          title: 'Token của bạn là',
          content: token,
        ),
      },
    );
    */
    await _secureStorage.write(_accessTokenKey, token);
  }

  @visibleForTesting
  Future<void> saveRefreshToken(String token) async {
    _isRefreshTokenInvalid = false;
    _refreshToken = token;
    await _secureStorage.write(_refreshTokenKey, token);
  }

  @visibleForTesting
  Future<void> saveExpiresTime(int tokenInMicroseconds) async {
    _tokenExpiresTime = tokenInMicroseconds;
    await _secureStorage.write(_tokenExpiresTimeKey, tokenInMicroseconds.toString());
  }

  Future<void> refreshTokenIfNeeded({
    required VoidCallback onPerform,
    required VoidCallback onComplete,
    required ValueSetter<Object> onCompleteError,
  }) async {
    try {
      await _refreshTokenCompleter?.future;

      if (_isRefreshTokenInvalid || isAccessTokenStillValid) return;

      onPerform();
      await performRefreshToken();
      onComplete();
    } catch (e) {
      onCompleteError(e);
    }
  }

  Future<void> performRefreshToken() async {
    try {
      _refreshTokenCompleter = Completer();

      final res = await ApiClient().fetch(
        ApiPath.refreshToken,
        RequestMethod.post,
        rawData: {
          'refresh-token': _refreshToken,
        },
      );

      if (res.hasError || !res.hasData) {
        notifyAuthenticationFailed();
        throw res.error!.messages;
      }

      saveAccessToken(res.data.lookup('access_token'));
      saveExpiresTime(res.data.lookup('expires_in'));
      saveRefreshToken(res.data.lookup('refresh_token'));
      _isRefreshTokenInvalid = false;
    } catch (e) {
      _isRefreshTokenInvalid = true;
      rethrow;
    } finally {
      _refreshTokenCompleter?.complete();
      _refreshTokenCompleter = null;
    }
  }

  bool get isAccessTokenStillValid => isAccessTokenExpired == false;

  bool get isAccessTokenExpired {
    final int currentTimeStamp = DateTime.now().microsecondsSinceEpoch;
    final int effectiveCurrentTimeStamp = int.parse(currentTimeStamp.toString().substring(0, 10));

    if (_tokenExpiresTime == null) return false;

    return _tokenExpiresTime! < effectiveCurrentTimeStamp;
  }

  bool isRefreshTokenRequest(RequestOptions options) {
    return options.path.contains(ApiPath.refreshToken);
  }

  bool isRefreshTokenResponse(Response response) {
    return response.realUri.path.contains(ApiPath.refreshToken);
  }

  bool isRefreshTokenErrorResponse(RequestOptions options) {
    return options.path.contains(ApiPath.refreshToken);
  }

  void notifyAuthenticated() => AppAuthenticationBinding.instance!.notifyAuthenticated();

  void notifyUnauthenticated() => AppAuthenticationBinding.instance!.notifyUnauthenticated();

  void notifyTokenChanged() => AppAuthenticationBinding.instance!.notifyTokenChanged();

  void notifyAuthenticationFailed() => AppAuthenticationBinding.instance!.notifyAuthenticationFailed();

  Future<void> clearToken() async {
    await _secureStorage.delete(_accessTokenKey);
    await _secureStorage.delete(_refreshTokenKey);
    await _secureStorage.delete(_tokenExpiresTimeKey);

    _accessToken = null;
    _refreshToken = null;
    _tokenExpiresTime = null;
    _isRefreshTokenInvalid = false;
  }

  void clearLoginInfo() {}

  Future invalid() async {
    await clearToken();
    clearLoginInfo();
  }

  Future<void> reload() async {
    await SpUtil.reload();
    await _secureStorage.reload();
    await _loadToken();
  }
}
