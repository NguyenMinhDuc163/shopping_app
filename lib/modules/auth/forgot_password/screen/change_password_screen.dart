import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/auth_flow/sign_in_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const String routeName = '/changePassword';
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: 'forgot_password.reset_password'.tr(),
      onClickBottomButton: (){
        Navigator.pushNamed(context, SignInScreen.routeName);
      },
      screen: Center(
        child: Padding(
          padding: AppPad.h22v10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: height_30,
            children: [
              Text(
                'forgot_password.new_password'.tr(),
                style: AppTextStyles.textHeader1,
              ),
              Spacer(),

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
                label: 'forgot_password.confirm_password'.tr(),
                controller: confirmPasswordController,
                hintText: "forgot_password.enter_new_password".tr(),
                validator: (text) {
                  return text.length >= 4;
                },
              ),

              Spacer(),
              Text(
                'forgot_password.enter_new_password'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
              ),
              AppGap.g1
            ],
          ),
        ),
      ),
    );
  }
}
