import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_state.dart';
import 'package:shopping_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class ResetPassController extends Disposable {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String username = '';
  ResetPassController({Map<String, String>? dataUser}) {
    if (dataUser != null) {
      username = dataUser['username'] ?? "";
    }
  }
  void onResetPassword(BuildContext context) {
    if (passwordController.text == '' || confirmPasswordController.text == '') {
      showToastTop(message: "forgot_password.enter_password".tr());
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showToastTop(message: "forgot_password.password_mismatch".tr());
      return;
    }
    context.read<ResetPassCubit>().onResetPassword(
      userName: username,
      password: confirmPasswordController.text,
    );
  }

  handleListener(BuildContext context, ResetPassState state) {
    if (state is ResetPassSuccess) {
      final data = {'username': username};

      Navigator.pushNamed(context, SignInScreen.routeName, arguments: data);
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
