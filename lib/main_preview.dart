import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shopping_app/core/public/navigation_service.dart';
import 'package:shopping_app/core/routes/routers.dart';
import 'package:shopping_app/modules/auth/initial/screen/splash_screen.dart';
import 'package:shopping_app/utils/helpers/local_storage_helper.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:device_preview_plus/device_preview_plus.dart';

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
    DevicePreview(
      enabled: true,
      builder:
          (context) => EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en', 'US'),
            startLocale: defaultLocale,
            child: const MyApp(),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: DevicePreview.appBuilder(context, child),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: DevicePreview.locale(context),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      onGenerateRoute: Routers.generateRoute,
      routes: Routers.routes,
      navigatorKey: NavigationService.navigatorKey,
      navigatorObservers: [NavigationService.routeObserver],
      home: const SplashScreen(),
    );
  }
}
