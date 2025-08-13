// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';

import 'exceptions.dart';

final _incorrectFormatRegex = RegExp(
  '(FormatException: '
  'Unexpected character'
  '|'
  'IncorrectJsonFormatException'
  '|'
  'DataParsingException'
  ')',
);

final _operationFailedFormatRegex = RegExp(
  '('
  'StateError'
  '|'
  '_TypeError'
  '|'
  'Failed assertion'
  ')',
);

enum AppErrorState {
  lostConnection,
  poorConnection,
  /// Có thể do kết nối không ổn định, server phản hồi chậm ...
  serverConnectionFailure,
  serverDataResponseStructureChanged,
  serverDataResponseStructureError,
  serverResponseNotFound,
  lookupServerFailure,
  systemOutOfMemoryToSaveFile,
  googlePlayServiceMissing,
  googlePlayServiceDisabled,
  uncatchableInternalLibraryError,
  unkownn;

  bool get isNetworkRelated {
    return const [
      lostConnection,
      poorConnection,
      serverConnectionFailure,
    ].contains(this);
  }

  bool get isUnkownn => this == unkownn;

  String get friendlyMessage {
    switch (this) {
      case AppErrorState.lostConnection:
        return 'Không có kết nối mạng.';
      case AppErrorState.poorConnection:
        return 'Kết nối mạng kém.';
      case AppErrorState.serverConnectionFailure:
        return 'Kết nối không thành công.\nVui lòng kiểm tra lại kết nối mạng của bạn và thử lại.';
      case AppErrorState.serverDataResponseStructureChanged:
        return 'Có vẻ như ứng dụng cần được cập nhật '
            'phiên bản mới để phản ánh những thay đổi ở phía chúng tôi.';
      case AppErrorState.serverResponseNotFound:
        return 'Không tìm thấy, nội dung bạn tìm kiếm không tồn tại trên hệ thống';
      case AppErrorState.lookupServerFailure:
      case AppErrorState.serverDataResponseStructureError:
        return 'Có vẻ như đã có sự cố xảy ra ở phía chúng tôi, vui lòng thử lại sau.';
      case AppErrorState.systemOutOfMemoryToSaveFile:
        return 'Thiết bị của bạn không còn đủ bộ nhớ để lưu tệp này.';
      case AppErrorState.googlePlayServiceMissing:
        return 'không có Google Play Service.';
      case AppErrorState.googlePlayServiceDisabled:
        return 'Google Play Service đã bị tắt.';
      case AppErrorState.uncatchableInternalLibraryError:
        return 'Đã có một sự cố bất ngờ xảy ra và chúng tôi đang cố gắng khắc phục.';
      case AppErrorState.unkownn:
        return 'Đã có lỗi xảy ra, vui lòng thử lại sau.';
    }
  }

  static String getFriendlyErrorString(
    Object e, {
    bool rethrowUnhandled = false,
  }) {
    if (e is String) {
      final String result;
      if (e.startsWith(_incorrectFormatRegex)) {
        result = AppErrorState.serverDataResponseStructureError.friendlyMessage;
      } else if (e.contains(_operationFailedFormatRegex)) {
        result = AppErrorState.serverDataResponseStructureError.friendlyMessage;
      } else {
        result = e;
      }

      return result;
    }

    if (e is FormatException) {
      return AppErrorState.serverDataResponseStructureError.friendlyMessage;
    }

    return getAppErrorState(
      e,
      rethrowUnhandled: rethrowUnhandled,
    ).friendlyMessage;
  }

  static AppErrorState getAppErrorState(
    Object e, {
    bool rethrowUnhandled = false,
  }) {
    if (e is NoConnectionException) return AppErrorState.lostConnection;
    if (e is PoorConnectionException) return AppErrorState.poorConnection;
    if (e is ServerConnectionFailureException) return AppErrorState.serverConnectionFailure;
    if (e is InternalServerErrorException) return AppErrorState.lookupServerFailure;
    if (e is DataParsingException || e is IncorrectJsonFormatException || e is FormatException)
      return AppErrorState.serverDataResponseStructureError;
    if (e is String && (e.startsWith(_incorrectFormatRegex) || e.contains(_operationFailedFormatRegex)))
      return AppErrorState.serverDataResponseStructureError;
    if (e is SystemOutOfMemoryToSaveFileException) return AppErrorState.systemOutOfMemoryToSaveFile;
    if (e is RequestedResourceNotFoundException) return AppErrorState.serverResponseNotFound;
    if (e is DioException && e.message?.contains('SocketException') == true) return AppErrorState.lostConnection;

    if (rethrowUnhandled) throw e;

    return AppErrorState.unkownn;
  }
}

/*
interface class ErrorStateObject {
  ErrorStateObject({
    required this.error,
    required this.errorState,
  });

  final String error;
  final AppErrorState errorState;
}

abstract class AbilityOfErrorStateObject {
  AbilityOfErrorStateObject({
    this.error,
    this.errorState,
  });

  final String? error;
  final AppErrorState? errorState;

  bool get hasError => error != null || errorState != null;
}
*/
