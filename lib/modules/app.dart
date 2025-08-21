import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopping_app/core/public/navigation_service.dart';
import 'package:shopping_app/core/routes/routers.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/services/auth_service.dart';
import 'package:shopping_app/modules/auth/initial/screen/splash_screen.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_state.dart';

import 'auth/sign_in/repository/sign_in_repo.dart';
import 'home/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authService});
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create:
          (context) => SignInRepo(
            apiClient: ApiClient(),
            authService: authService,
          ),
      child: BlocProvider(
        create: (context) => SignInCubit(repo: context.read<SignInRepo>()),
        child: MaterialApp(
          builder: (context, child) {
            return BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state is SignInAuthenticated) {
                  NavigationService.navigatorKey.currentState
                      ?.pushReplacementNamed(HomeScreen.routeName);
                } else if (state is SignInInitial) {
                  NavigationService.navigatorKey.currentState
                      ?.pushReplacementNamed(SplashScreen.routeName);
                }
              },
              child: ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                    start: 1921,
                    end: double.infinity,
                    name: '4K',
                  ),
                ],
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: Routers.routes,
          // initialRoute: '/',
          onGenerateRoute: Routers.generateRoute,
          navigatorKey: NavigationService.navigatorKey,
          navigatorObservers: [NavigationService.routeObserver],
        ),
      ),
    );
  }
}
