
import 'package:shopping_app/utils/helpers/string_extension.dart';

import 'app_event_service.dart';

abstract final class AppStatus {
  // ignore: unused_element
  AppStatus._();

  static Future<void> ensureInitialized() async {
    await AppEventLogging.ensureInitialized();
  }

  static bool get isFirstTimeAppLaunch => AppEventLogging.firstLaunchAt.isBlank;
  static bool get hasUserNotUsedApp => AppEventLogging.userStartExperienceAt.isBlank;
  static bool get didUserCompleteFirstExperience => AppEventService.didUserCompleteFirstExperience;

  static DateTime? get firstLaunchAt {
    final time = AppEventLogging.firstLaunchAt;
    if (time == null) return null;
    return DateTime.parse(time);
  }

  static bool get didAppLaunchFromUpdate => AppEventLogging.firstLaunchAt.isBlank;
}
