import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {

    return FunctionScreenTemplate(
      titleButtonBottom: 'sign_up.title'.tr(),
      screen: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'sign_up.title'.tr(),
              style: AppTextStyles.text.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
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
            TextInputCustom(
              label: 'Email'.tr(),
              controller: passwordController,
              hintText: "sign_up.enter_email".tr(),
              validator: (text) {
                return Validators.isValidEmail(text);
              },
            ),
            Padding(
              padding: AppPad.h22v10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("sign_up.remember_me".tr()),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeColor: Colors.green, // Màu khi bật
                  ),
                ],
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
