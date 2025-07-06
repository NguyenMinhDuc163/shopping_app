import 'package:flutter/material.dart';
import 'package:shopping_app/core/public/global_utils.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/modules/auth/fogot_password/change_password_screen.dart';
import 'package:shopping_app/modules/auth/fogot_password/forgot_password_screen.dart';
import 'package:shopping_app/modules/auth/fogot_password/verify_screen.dart';
import 'package:shopping_app/modules/auth/screens/login_screen.dart';
import 'package:shopping_app/modules/auth/screens/onboarding_screen.dart';
import 'package:shopping_app/modules/auth/screens/sign_in_screen.dart';
import 'package:shopping_app/modules/auth/screens/sign_up_screen.dart';
import 'package:shopping_app/modules/dashboard/dashboard_screen.dart';
import 'package:shopping_app/modules/home/home_screen.dart';

class Routers {
  static Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    GlobalUtils.ROUTES = settings.name;
    print("Global Routes ------------${settings.name}");
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case VerifyScreen.routeName:
        return MaterialPageRoute(builder: (_) => VerifyScreen());
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => FunctionScreenTemplate(
                title: "Chức năng đang trong quá trình phát triển",
                isShowBottomButton: false,
                screen: Center(
                  child: Text(
                    "Chức năng đang trong quá trình phát triển",
                    style: AppTextStyles.text,
                  ),
                ),
              ),
        );
    }
  }
}
