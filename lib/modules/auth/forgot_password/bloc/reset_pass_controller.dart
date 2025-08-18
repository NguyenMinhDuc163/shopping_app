import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_state.dart';
import 'package:shopping_app/modules/auth/sign_in/screen/sign_in_screen.dart';

class ResetPassController extends Disposable{
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void onResetPassword(BuildContext context, ) {

    context.read<ResetPassCubit>().onResetPassword(userName: "sdsa", password: confirmPasswordController.text);
  }

  handleListener(BuildContext context, ResetPassState state) {
    if (state is ResetPassSuccess) {
      Navigator.pushNamed(context, SignInScreen.routeName);
    }

    if (state is ResetPassFailure || state is ResetPassError) {
      showToastTop(message: 'forgot_password.failure'.tr());
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}