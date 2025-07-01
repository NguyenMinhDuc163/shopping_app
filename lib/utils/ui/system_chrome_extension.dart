import 'package:flutter/services.dart';

/// Controls specific aspects of the operating system's graphical interface and
/// how it interacts with the application.
extension SystemChromeExtension on SystemChrome {
  static Future<void> allowVerticalPortraitOnly() =>
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  static Future<void> makeSystemOverlaysDisplayedPermanently() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}