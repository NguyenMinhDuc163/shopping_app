import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sp_util/sp_util.dart';

import 'app_status.dart';

const _source = 'AppEventService';

abstract final class AppEventService {
  /* =
  static FirebaseCrashlytics get _firebaseCrashlytics => FirebaseCrashlytics.instance;

  static FirebaseAnalyticsObserver createFirebaseAnalyticsRouteObserver({
    ScreenNameExtractor? screenNameExtractor,
    Function(PlatformException error)? onError,
  }) {
    return FirebaseAnalyticsObserver(
      analytics: FirebaseAnalytics.instance,
      nameExtractor: screenNameExtractor ?? defaultNameExtractor,
      onError: onError,
    );
  }
  */

  static Future<void> ensureInitialized() async {
    await AppStatus.ensureInitialized();
    await AppEventLogging.ensureInitialized();

    if (AppStatus.hasUserNotUsedApp) {
      _onUserCompleteFirstExperience = Completer();
    }
  }

  static void notifyAppLaunch() {
    if (AppStatus.isFirstTimeAppLaunch) {
      AppEventLogging._logEventFirstTimeAppLaunch();
    }
  }

  static void notifyUserStartExperience() {
    if (AppStatus.hasUserNotUsedApp) {
      AppEventLogging._logEventUserStartExperience();
      _onUserCompleteFirstExperience?.complete();
    }
  }

  static Completer? _onUserCompleteFirstExperience;
  static Future? get onUserCompleteFirstExperience => _onUserCompleteFirstExperience?.future;
  static bool get didUserCompleteFirstExperience {
    return _onUserCompleteFirstExperience == null || _onUserCompleteFirstExperience?.isCompleted == false;
  }

  static Future<void> notifyUserLogin({
    required final String userId,
  }) {
    return _safeWait(futures: [
      // _firebaseCrashlytics.setUserIdentifier(userId),
    ]);
  }

  static Future<void> notifyUserSignOut() {
    return _safeWait(futures: [
      // _firebaseCrashlytics.setUserIdentifier(''),
    ]);
  }
}

Future<List<T>> _safeWait<T>({
  final Future<T>? future,
  final Iterable<Future<T>>? futures,
}) {
  try {
    return Future.wait([
      if (future != null) future,
      ...?futures,
    ]);
  } catch (e) {
    if (kDebugMode) log(e.toString(), name: _source);
    return Future.error(e);
  }
}

const String _firstLaunchAtKey = 'first_launch_at_key';
const String _firstTimeExperienceAtKey = 'first_time_experience_at_key';

abstract final class AppEventLogging {
  static Future<void> ensureInitialized() async {
    await SpUtil.getInstance();
  }

  static String? get firstLaunchAt => SpUtil.getString(_firstLaunchAtKey);

  static void _logEventFirstTimeAppLaunch() {
    SpUtil.putString(_firstLaunchAtKey, DateTime.now().toString());
  }

  static String? get userStartExperienceAt => SpUtil.getString(_firstTimeExperienceAtKey);

  static void _logEventUserStartExperience() {
    SpUtil.putString(_firstTimeExperienceAtKey, DateTime.now().toString());
  }
}
