import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/reset_password_screen.dart';

class VerifyOtpController extends Disposable{
  TextEditingController otpController = TextEditingController();
  String username = '';
  VerifyOtpController({Map<String, String>? dataUser}) {
    if (dataUser != null) {
      username = dataUser['username'] ?? "";
    }
  }

  @override
  void dispose() {
    otpController.dispose();
  }

  void onSubmitOpt(BuildContext context,{String? value}) {
    context.read<VerifyOtpCubit>().onVerifyOtp(userName: username, otp: value ?? otpController.text);
  }

  handleListener(BuildContext context, VerifyOtpState state) {
    if (state is VerifyOtpSuccess) {
      final data = {
        'username': username,
      };

      Navigator.pushNamed(
        context,
        ResetPasswordScreen.routeName,
        arguments: data,
      );
    }

    if (state is VerifyOtpFailure || state is VerifyOtpError) {
      showToastTop(message: 'forgot_password.otp_send_failure'.tr());
    }
  }

}