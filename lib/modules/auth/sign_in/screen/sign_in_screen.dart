import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:shopping_app/modules/auth/initial/screen/onboarding_screen.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_controller.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_state.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/sign_in_repo.dart';
import 'package:shopping_app/modules/auth/widgets/text_span_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signInScreen';

  @override
  Widget build(BuildContext context) {
    final Map<String, String>? prefillData = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    return DisposableProvider(
      create: (BuildContext context) {
        return SignInController(prefillData: prefillData);
      },
      builder: (context, child) {
        final SignInController controller =
            DisposableProvider.of<SignInController>(context);
        return _buildContent(context, controller);
      },
    );
  }

  Widget _buildContent(BuildContext context, SignInController controller) {
    return BlocListener<SignInCubit, SignInState>(
      listener: controller.handleListener,
      child: FunctionScreenTemplate(
        titleButtonBottom: 'login.title'.tr(),
        onClickBottomButton: (){
          controller.onSignIn(context);
        },
        screen: BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            final Widget initialWidget = Padding(
              padding: AppPad.h22v10,
              child: Column(
                spacing: height_30,
                children: [
                  Text("login.welcome".tr(), style: AppTextStyles.textHeader1),
                  Text(
                    "login.enter_data_to_continue".tr(),
                    style: AppTextStyles.textContent1.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                  Spacer(),
                  TextInputCustom(
                    label: 'sign_up.username'.tr(),
                    controller: controller.usernameController,
                    hintText: "sign_up.enter_username".tr(),
                    validator: (text) {
                      return text.length >= 4;
                    },
                  ),
                  TextInputCustom(
                    label: 'sign_up.password'.tr(),
                    controller: controller.passwordController,
                    hintText: "sign_up.enter_password".tr(),
                    suffixIcon: Text(
                      "sign_up.strong".tr(),
                      style: AppTextStyles.textContent3.copyWith(
                        color: AppColors.limeGreen,
                      ),
                    ),
                    validator: (text) {
                      return text.length >= 8;
                    },
                  ),

                  GestureDetector(
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          ForgotPasswordScreen.routeName,
                        ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "login.forgot_password".tr(),
                        style: AppTextStyles.textContent1.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "sign_up.remember_me".tr(),
                        style: AppTextStyles.textContent2,
                      ),
                      SwitchBottomWidget(
                        onChanged: (value) {
                          context
                              .read<SignInRepo>()
                              .authLocalDataSource
                              .deleteToken();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  TextSpanWidget(
                    normalText: "${'login.connect_account_confirmation'.tr()} ",
                    clickableText: 'login.terms_and_conditions'.tr(),
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          SignInScreen.routeName,
                        ),
                  ),
                ],
              ),
            );

            final Widget inProgressWidget = Center(
              child: CircularProgressIndicator(),
            );

            return (switch (state) {
              SignInInitial() => initialWidget,
              SignInInProgress() => inProgressWidget,
              SignInSuccess() => initialWidget,
              SignInFailure() => initialWidget,
              SignInError() => initialWidget,
              _ => Container(),
            });
          },
        ),
      ),
    );
  }
}
