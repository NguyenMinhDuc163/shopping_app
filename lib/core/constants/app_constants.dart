abstract final class AppConst {
  // TODO: uodate app name
  static const String appName = '';

  static const String robotoFont = 'Roboto';

  // Business

  static const int otpLength = 6;

  static const int minPasswordLength = 6;

  // ignore: library_private_types_in_public_api, non_constant_identifier_names
  static final _RegExp Pattern = _RegExp();

  // UI

  static const Duration splashScreenDuration = Duration(milliseconds: 350);

  // Api

  static const int refetchApiThreshold = 3;

  static const int limitOfItemsForPeekRequest = 5;

  static const int limitOfItemsForEachRequest = 10;

  static const Duration timesToFetchCommonDataAgain = Duration(days: 7);

  static const int inputDebounceTimeInMilliseconds = 440;
}

final class _RegExp {
  final RegExp nonWord = RegExp(
    r'[^\d\p{L}-]+',
    multiLine: true,
    unicode: true,
  );

  final RegExp specialCharacters = RegExp(
    r'[!@#$%^&.*+?{}()|[\]\\]',
  );

  final RegExp email = RegExp(
    r'^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$',
  );

  final RegExp number = RegExp(r'\d');
}
