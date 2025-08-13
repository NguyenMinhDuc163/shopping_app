
import 'dart:developer';

import 'package:flutter/foundation.dart';

final class SystemUtils {
  SystemUtils._();


  static void debugPrint(String message) {
    if (kDebugMode) {
      print(message);
    }
  }

  static final DebugLog debugLog = DebugLog._();
  static final ColorizeTerminalText colorizeTerminalText = ColorizeTerminalText._();
}

final class DebugLog {
  DebugLog._();

  void call(
    String source,
    String message, {
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      log(
        message,
        name: source,
        stackTrace: stackTrace,
      );
    }
  }

  info(String source, String message) {
    if (kDebugMode) log(message, name: source, level: 300);
  }

  error(
    String source,
    String message, {
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      log(
        message,
        name: source,
        level: 1000,
        stackTrace: stackTrace,
      );
    }
  }

  String colorizeSource(String source, TerminalTextColor color) {
    return _ANSIEscapeCode.reset + color.build(source) + _ANSIEscapeCode.reset + TerminalTextColor.red.code;
  }
}

final class ColorizeTerminalText {
  ColorizeTerminalText._();

  String _build(String text, TerminalTextColor color) {
    return _ANSIEscapeCode.reset + _ANSIEscapeCode.build(text, color);
  }

  String yellow(String text) {
    return _build(text, TerminalTextColor.yellow);
  }

  String blue(String text) {
    return _build(text, TerminalTextColor.blue);
  }

  String cyan(String text) {
    return _build(text, TerminalTextColor.cyan);
  }
}

abstract final class _ANSIEscapeCode {
  static const reset = '\x1B[0m';

  static String build(
    String text,
    TerminalTextColor color,
  ) {
    return color.build(text) + reset;
  }
}

/// ANSI Escape Color
final class TerminalTextColor {
  const TerminalTextColor(this.code);

  final String code;

  static const black = TerminalTextColor('\x1B[30m');
  static const red = TerminalTextColor('\x1B[31m');
  static const green = TerminalTextColor('\x1B[32m');
  static const yellow = TerminalTextColor('\x1B[33m');
  static const blue = TerminalTextColor('\x1B[34m');
  static const magenta = TerminalTextColor('\x1B[35m');
  static const cyan = TerminalTextColor('\x1B[36m');
  static const white = TerminalTextColor('\x1B[37m');

  String build(String text) => '$code$text';
}
