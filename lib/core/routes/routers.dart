import 'package:flutter/material.dart';
import 'package:shopping_app/core/public/global_utils.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/modules/auth/auth_flow/sign_in_screen.dart';
import 'package:shopping_app/modules/auth/auth_flow/sign_up_screen.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/change_password_screen.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/verify_screen.dart';
import 'package:shopping_app/modules/auth/auth_flow/login_screen.dart';
import 'package:shopping_app/modules/auth/initial/screen/onboarding_screen.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/dashboard/dashboard_screen.dart';
import 'package:shopping_app/modules/home/screen/home_screen.dart';
import 'package:shopping_app/modules/payment/screen/address_form_screen.dart';
import 'package:shopping_app/modules/payment/screen/confirm_screen.dart';
import 'package:shopping_app/modules/payment/screen/new_card_screen.dart';
import 'package:shopping_app/modules/payment/screen/payment_method_screen.dart';
import 'package:shopping_app/modules/product/screen/detail_product.dart';

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
      case DetailProduct.routeName:
        return MaterialPageRoute(builder: (_) => DetailProduct());
      case AddressFormScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddressFormScreen());
      case ConfirmScreen.routeName:
        return MaterialPageRoute(builder: (_) => ConfirmScreen());
      case NewCardScreen.routeName:
        return MaterialPageRoute(builder: (_) => NewCardScreen());
      case PaymentMethodScreen.routeName:
        return MaterialPageRoute(builder: (_) => PaymentMethodScreen());
      case CartScreen.routeName:
        return MaterialPageRoute(builder: (_) => CartScreen());
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
