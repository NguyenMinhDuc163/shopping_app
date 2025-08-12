import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/theme/app_text_theme.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:shopping_app/modules/auth/initial/screen/onboarding_screen.dart';

import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/widgets/text_span_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: 'login.title'.tr(),
      onClickBottomButton:
          () => Navigator.pushNamed(context, OnboardingScreen.routeName),
      screen: Padding(
        padding: AppPad.h22v10,
        child: Column(
          spacing: height_30,
          children: [
            Text("login.welcome".tr(), style: AppTextStyles.textHeader1),
            Text(
              "login.enter_data_to_continue".tr(),
              // style: AppTextTheme.base.s12.copyWith(color: Colors.red),
                style: AppTextStyles.textContent1.copyWith(
                  color: AppColors.coolGray,
                )
            ),
            Spacer(),
            TextInputCustom(
              label: 'sign_up.username'.tr(),
              controller: usernameController,
              hintText: "sign_up.enter_username".tr(),
              validator: (text) {
                return text.length >= 4;
              },
            ),
            TextInputCustom(
              label: 'sign_up.password'.tr(),
              controller: passwordController,
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
                  style: AppTextStyles.textContent1.copyWith(color: Colors.red),
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
                SwitchBottomWidget(onChanged: (value) {}),
              ],
            ),
            Spacer(),
            TextSpanWidget(
              normalText: "${'login.connect_account_confirmation'.tr()} ",
              clickableText: 'login.terms_and_conditions'.tr(),
              onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
