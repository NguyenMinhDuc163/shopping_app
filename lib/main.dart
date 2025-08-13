import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/utils/helpers/local_storage_helper.dart';

import 'firebase_options.dart';
import 'modules/app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences sf = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();

  Locale defaultLocale = const Locale('en', 'US');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: defaultLocale,
      child: App(sharedPreferences: sf),
    ),
  );
}