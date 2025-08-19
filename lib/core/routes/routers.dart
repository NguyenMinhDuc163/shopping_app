import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/public/global_utils.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/repository/forgot_pass_repo.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/reset_password_screen.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/verify_screen.dart';
import 'package:shopping_app/modules/auth/initial/screen/onboarding_screen.dart';
import 'package:shopping_app/modules/auth/initial/screen/splash_screen.dart';
import 'package:shopping_app/modules/auth/login/screen/login_screen.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_controller.dart';
import 'package:shopping_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_cubit.dart';
import 'package:shopping_app/modules/auth/sign_up/repository/sign_up_repo.dart';
import 'package:shopping_app/modules/auth/sign_up/screen/sign_up_screen.dart';
import 'package:shopping_app/modules/brand/screen/brain_screen.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/dashboard/screen/dashboard_screen.dart';
import 'package:shopping_app/modules/home/screen/home_screen.dart';
import 'package:shopping_app/modules/payment/screen/address_form_screen.dart';
import 'package:shopping_app/modules/payment/screen/confirm_screen.dart';
import 'package:shopping_app/modules/payment/screen/new_card_screen.dart';
import 'package:shopping_app/modules/payment/screen/payment_method_screen.dart';
import 'package:shopping_app/modules/product/screen/detail_product.dart';
import 'package:shopping_app/modules/reviews/screen/add_review_screen.dart';
import 'package:shopping_app/modules/reviews/screen/review_screen.dart';

//part of in dart
class Routers {
  static Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    GlobalUtils.ROUTES = settings.name;
    // TODO Task 1: hiển thị log khi chuyển màn

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(settings: settings, builder: (_) => const SplashScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => LoginScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => HomeScreen());
      case DashboardScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => DashboardScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (context) => RepositoryProvider(
                create: (context) => SignUpRepo(apiClient: ApiClient()),
                child: BlocProvider(
                  create: (context) => SignUpCubit(repo: context.read<SignUpRepo>()),
                  child: SignUpScreen(),
                ),
              ),
        );
      case SignInScreen.routeName:
        final Map<String, String>? prefillData = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => DisposableProvider(
                create: (BuildContext context) {
                  return SignInController(prefillData: prefillData);
                },
                child: SignInScreen(),
              ),
        );
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (context) => RepositoryProvider(
                create: (context) => ForgotPassRepo(apiClient: ApiClient()),
                child: BlocProvider(
                  create: (context) => ForgotPassCubit(repo: context.read<ForgotPassRepo>()),
                  child: ForgotPasswordScreen(),
                ),
              ),
        );

      case VerifyScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (context) => RepositoryProvider(
                create: (context) => ForgotPassRepo(apiClient: ApiClient()),

                child: BlocProvider(
                  create: (context) => VerifyOtpCubit(repo: context.read<ForgotPassRepo>()),

                  child: VerifyScreen(),
                ),
              ),
        );

      case ResetPasswordScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (context) => RepositoryProvider(
                create: (context) => ForgotPassRepo(apiClient: ApiClient()),

                child: BlocProvider(
                  create: (context) => ResetPassCubit(repo: context.read<ForgotPassRepo>()),

                  child: ResetPasswordScreen(),
                ),
              ),
        );

      case DetailProduct.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => DetailProduct());
      case AddressFormScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => AddressFormScreen());
      case ConfirmScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => ConfirmScreen());
      case NewCardScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => NewCardScreen());
      case PaymentMethodScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => PaymentMethodScreen());
      case CartScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => CartScreen());
      case ReviewScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => ReviewScreen());
      case AddReviewScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => AddReviewScreen());
      case BrainScreen.routeName:
        Map<String, dynamic> brand = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(settings: settings, builder: (_) => BrainScreen(brand: brand));
      default:
        return MaterialPageRoute(
          settings: settings,
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
