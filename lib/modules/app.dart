import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/public/navigation_service.dart';
import 'package:shopping_app/core/routes/routers.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/modules/auth/auth_flow/bloc/auth_cubit.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/auth_local_data_source.dart';
import 'package:shopping_app/modules/auth/initial/screen/splash_screen.dart';

import 'auth/auth_flow/repository/auth_repo.dart';

class App extends StatelessWidget {
  const App({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepo(
        apiClient: ApiClient(),
        authLocalDataSource: AuthLocalDataSource(sharedPreferences)
      ),
      child: BlocProvider(
        create: (context) => AuthCubit(repo: context.read<AuthRepo>(),),
        child: MaterialApp(
          builder:
              (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const SplashScreen(),
          routes: Routers.routes,
          onGenerateRoute: Routers.generateRoute,
          navigatorKey: NavigationService.navigatorKey,
          navigatorObservers: [NavigationService.routeObserver],
        ),
      ),
    );
  }
}
