import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._();

  static Future<bool> canConnectToNetwork() async {
    final List<ConnectivityResult> result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      if (Platform.isIOS) {
        // https://pub.dev/packages/connectivity_plus#ios--macos
        //
        // ```
        // Starting with iOS 12 and MacOS 10.14,
        // the implementation uses NWPathMonitor to obtain
        // the enabled connectivity types. We noticed that this observer
        // can give multiple or unreliable results.
        // For example, reporting connectivity "none" followed by
        // connectivity "wifi" right after reconnecting.
        //
        // We recommend to use the onConnectivityChanged with
        // this limitation in mind, as the method doesn't filter events,
        // nor it ensures distinct values.
        // ```
        if (result.length == 1) return false;
      } else {
        return false;
      }
    }

    return await _checkConnection();
  }

  static Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
