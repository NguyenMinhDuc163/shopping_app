import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/utils/helpers/local_storage_helper.dart';

class Utils {
  static Future<void> setLocale(BuildContext context) async {
    String? savedLocale = await LocalStorageHelper.getValue('languageCode');
    bool isVietnamese = savedLocale == 'vi';
    print('Current locale: ${context.locale}');
    print('Current title: ${"home_screen.title".tr()}');
    if (isVietnamese) {
      await context.setLocale(const Locale('en', 'US'));
      await LocalStorageHelper.setValue('languageCode', 'en');
    } else {
      await context.setLocale(const Locale('vi', 'VN'));
      await LocalStorageHelper.setValue('languageCode', 'vi');
    }
  }
}
