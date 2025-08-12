import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/verify_screen.dart';
import 'package:shopping_app/utils/helpers/validators.dart';
import 'package:shopping_app/init.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = '/forgotPassword';
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: "forgot_password.confirm_mail".tr(),
      onClickBottomButton: () => Navigator.pushNamed(context,VerifyScreen.routeName),
      screen: Padding(
        padding: AppPad.h22v10,
        child: Center(
          child: Column(
            spacing: height_30,
            children: [
              Text(
                "forgot_password.title".tr(),
                style: AppTextStyles.textHeader1,
              ),
              SvgPicture.asset(ImagePath.imgForgotPassword),
              AppGap.g2,
              TextInputCustom(
                label: 'Email'.tr(),
                controller: emailController,
                hintText: "forgot_password.email_address".tr(),
                validator: (text) {
                  return Validators.isValidEmail(text);
                },
              ),
              Spacer(),
              Text(
                'forgot_password.enter_email_for_confirmation'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
              ),
              AppGap.g1,
            ],
          ),
        ),
      ),
    );
  }
}
