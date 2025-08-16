import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/public/navigation_service.dart';
import 'package:shopping_app/core/routes/routers.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/modules/auth/initial/screen/splash_screen.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/auth_local_data_source.dart';

import 'modules/auth/sign_in/repository/sign_in_repo.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences sf = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();

  Locale defaultLocale = const Locale('en', 'US');

  runApp(
    DevicePreview(
      enabled: true,
      builder:
          (context) => EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en', 'US'),
            startLocale: defaultLocale,
            child: MyApp(sharedPreferences: sf),
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
const MyApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SignInRepo(
          apiClient: ApiClient(),
          authLocalDataSource: AuthLocalDataSource(sharedPreferences)
      ),
      child: BlocProvider(
        create: (context) => SignInCubit(repo: context.read<SignInRepo>(),),
        child: MaterialApp(
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
        ),
      ),
    );
  }
}