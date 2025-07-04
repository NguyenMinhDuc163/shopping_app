import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shopping_app/core/public/navigation_service.dart';
import 'package:shopping_app/core/routes/routers.dart';
import 'package:shopping_app/modules/auth/screens/splash_screen.dart';
import 'package:shopping_app/utils/helpers/local_storage_helper.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:device_preview_plus/device_preview_plus.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();

  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
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
      locale: DevicePreview.locale(context),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      onGenerateRoute: Routers.generateRoute,
      routes: Routers.routes,
      navigatorKey: NavigationService.navigatorKey,
      home: const SplashScreen(),
    );
  }
}
