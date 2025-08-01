import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/utils/helpers/validators.dart';
import 'package:shopping_app/init.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: 'sign_up.title'.tr(),
      onClickBottomButton: () {
        Navigator.pushNamed(context, SignInScreen.routeName);
      },
      screen: Center(
        child: Padding(
          padding: AppPad.h22v10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: height_30,
            children: [
              Text('sign_up.title'.tr(), style: AppTextStyles.textHeader1),
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
                controller: emailController,
                hintText: "sign_up.enter_email".tr(),
                validator: (text) {
                  return Validators.isValidEmail(text);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "sign_up.remember_me".tr(),
                    style: AppTextStyles.textContent3,
                  ),
                  SwitchBottomWidget(onChanged: (value) {}),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
