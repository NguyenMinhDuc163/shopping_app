import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopping_app/core/constants/image_path.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_dimension.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/modules/auth/forgot_password/change_password_screen.dart';
import 'package:shopping_app/modules/auth/widgets/countdown_widget.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});
  static const String routeName = '/verifyScreen';
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: "forgot_password.confirm_code".tr(),
      onClickBottomButton: () => Navigator.pushNamed(context, ChangePasswordScreen.routeName),
      screen: Padding(
        padding: AppPad.h22v10,
        child: Center(
          child: Column(
            spacing: height_30,
            children: [
              Text(
                "forgot_password.verification_code".tr(),
                style: AppTextStyles.textHeader1,
              ),
              SvgPicture.asset(ImagePath.imgForgotPassword),
              AppGap.g2,
              PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 70,
                  fieldWidth: 60,
                  activeColor: Colors.grey[300]!,
                  selectedColor: Colors.grey[400]!,
                  inactiveColor: Colors.grey[200]!,
                ),
                textStyle: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.number,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountdownWidget(seconds: 120, onResend: () {}),
                  Text(
                    'forgot_password.resend_confirmation_code'.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textContent2.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                ],
              ),
              AppGap.g1,
            ],
          ),
        ),
      ),
    );
  }
}
