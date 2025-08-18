import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/verify_screen.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class ForgotPassController extends Disposable{
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
  }

  void onSendOpt(BuildContext context, ) {
    if(!Validators.isValidEmail(emailController.text.trim())) {
      showToastTop(message: "forgot_password.invalid_email".tr());
      return;
    }
    context.read<ForgotPassCubit>().onSendOtp(email: emailController.text);
  }

  handleListener(BuildContext context, ForgotPassState state) {
    if (state is ForgotPassSuccess) {
      Navigator.pushNamed(context, VerifyScreen.routeName);
    }

    if (state is ForgotPassFailure || state is ForgotPassError) {
      showToastTop(message: 'forgot_password.otp_send_failure'.tr());
    }
  }

}