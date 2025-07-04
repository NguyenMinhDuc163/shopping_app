import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:shopping_app/utils/helpers/local_storage_helper.dart';

import 'modules/app.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await EasyLocalization.ensureInitialized();

  String? savedLocale = await LocalStorageHelper.getValue('languageCode');
  Locale defaultLocale = const Locale('en', 'US');
  if (savedLocale != null) {
    if (savedLocale == 'vi') {
      defaultLocale = const Locale('vi', 'VN');
    } else {
      defaultLocale = const Locale('en', 'US');
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: defaultLocale,
      child: const App(),
    ),
  );
}
