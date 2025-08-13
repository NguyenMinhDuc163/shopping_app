// ignore_for_file: use_super_parameters

abstract class AppException implements Exception {
  final String? message;
  final String? from;

  const AppException(this.message, this.from);
}

class UnhandledException extends AppException {
  const UnhandledException([String? message, String? from]) : super(message ?? 'Unkown', from);

  @override
  String toString() {
    return '''
UnhandledException: $message

From: $from
''';
  }
}

class DataNotFoundException extends AppException {
  const DataNotFoundException(String message, [String? from]) : super(message, from);

  /*
  static DataNotFoundException whereValueOfFieldBuilder<T extends Object>({
    required String fieldName,
    required Object? value,
    String? source,
  }) =>
      DataNotFoundException(
        "${T.toString()}.$fieldName == $value",
        source == null ? null : "${T.toString()}.$source",
      );
  */

  @override
  String toString() {
    return '''
DataNotFoundException: $message not found

From: $from
''';
  }
}

class InternalServerErrorException extends AppException {
  const InternalServerErrorException([String? message, String? from]) : super(message, from);

  @override
  String toString() {
    return '''
InternalServerException: $message

From: $from
''';
  }
}

class NoConnectionException extends AppException {
  const NoConnectionException([String? message, String? from]) : super(message, from);

  @override
  String toString() {
    return '''
NoConnectionException: $message

From: $from
''';
  }
}

class PoorConnectionException extends AppException {
  const PoorConnectionException([String? message, String? from]) : super(message, from);

  @override
  String toString() {
    return '''
PoorConnectionException: $message

From: $from
''';
  }
}

class ServerConnectionFailureException extends AppException {
  const ServerConnectionFailureException([String? message, String? from]) : super(message, from);

  @override
  String toString() {
    return '''
ServerConnectionFailureException: $message

From: $from
''';
  }
}

class DataParsingException extends AppException {
  const DataParsingException(String message, [String? from]) : super(message, from);

  @override
  String toString() {
    return '''
DataParsingException: $message

From: $from
''';
  }
}

class IncorrectJsonFormatException implements Exception {
  const IncorrectJsonFormatException();

  @override
  String toString() => 'IncorrectJsonFormatException: Định dạng Json sai';
}

class DataMappingException extends AppException {
  const DataMappingException(String message, [String? from]) : super(message, from);

  @override
  String toString() {
    return '''
DataMappingException: $message

From: $from
''';
  }
}

class FileNotFoundException implements Exception {
  const FileNotFoundException();

  @override
  String toString() => 'Không tìm thấy file!';
}

class SystemOutOfMemoryToSaveFileException implements Exception {}

class PermissionDeniedException implements Exception {
  const PermissionDeniedException(this.message);

  final String message;

  @override
  String toString() => "Permission denied: $message";
}

class RequestedResourceNotFoundException implements Exception {}

class RequestedResourceLockedException implements Exception {
  const RequestedResourceLockedException([this.message]);

  final dynamic message;

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "The requested resource has been locked";

    return "The requested resource has been locked: $message";
  }
}

class RequestedResourceRequireAuthorizationException implements Exception {
  const RequestedResourceRequireAuthorizationException([this.message]);

  final dynamic message;

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "The requested resource has been locked";

    return "The requested resource has been locked: $message";
  }
}
