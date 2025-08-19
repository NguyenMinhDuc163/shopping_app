import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_controller.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/reset_password_screen.dart';
import 'package:shopping_app/modules/auth/widgets/countdown_widget.dart';
import 'package:shopping_app/init.dart';


class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});
  static const String routeName = '/verifyScreen';
  @override
  Widget build(BuildContext context) {
    return DisposableProvider(
        create: (BuildContext context) {
          return VerifyOtpController();
        },
        builder: (context, child){
          final VerifyOtpController controller = DisposableProvider.of<VerifyOtpController>(
            context,
          );
          return BlocListener<VerifyOtpCubit, VerifyOtpState>(
              listener: controller.handleListener,
              listenWhen: (previous, next) => previous.runtimeType != next.runtimeType,
              child: buildContent(context, controller));
        });
  }
  Widget buildContent(BuildContext context, VerifyOtpController controller){
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state){

        final initialWidget = FunctionScreenTemplate(
          titleButtonBottom: "forgot_password.confirm_code".tr(),
          onClickBottomButton: () {
            controller.onSubmitOpt(context);
          },
          screen: Padding(
            padding: AppPad.h22v10,
            child: Center(
              child: SingleChildScrollView(
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
                      // controller: controller.otpController,
                      length: 4,
                      onChanged: (value) {},
                      onCompleted: (value){
                        controller.onSubmitOpt(context, value: value);
                      },
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
                    AppGap.h100,
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
          ),
        );

        final Widget inProgressWidget = Center(
          child: CircularProgressIndicator(),
        );
        return (switch (state) {
          VerifyOtpInitial() => initialWidget,
          VerifyOtpInProgress() => inProgressWidget,
          VerifyOtpSuccess() => initialWidget,
          VerifyOtpFailure() => initialWidget,
          VerifyOtpError() => initialWidget,
        });
      },
    );
  }
}
