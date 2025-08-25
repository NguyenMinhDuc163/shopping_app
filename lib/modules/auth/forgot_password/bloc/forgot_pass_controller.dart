import 'dart:async';
import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/screen/verify_screen.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class ForgotPassController extends Disposable {
  TextEditingController userNameController = TextEditingController();

  Timer? _usernameDebounceTimer;
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void _onUsernameChanged() {
    final username = userNameController.text.trim();

    _usernameDebounceTimer?.cancel();

    if (username.length >= 3) {
      _usernameDebounceTimer = Timer(const Duration(milliseconds: 500), () {
        if (_context != null) {
          _context!.read<ForgotPassCubit>().checkUserName(username: username);
        }
      });
    }
  }

  void initializeUsernameListener() {
    userNameController.addListener(_onUsernameChanged);
  }

  @override
  void dispose() {
    _usernameDebounceTimer?.cancel();
    userNameController.dispose();
  }

  void onSendOpt(BuildContext context) {
    if (userNameController.text.trim() == '') {
      showToastTop(message: "login.enter_data_to_continue".tr());
      return;
    }
    context.read<ForgotPassCubit>().onSendOtp(
      username: userNameController.text,
    );
  }

  handleListener(BuildContext context, ForgotPassState state) {
    if (state is ForgotPassSuccess) {
      final data = {'username': userNameController.text};

      Navigator.pushNamed(context, VerifyScreen.routeName, arguments: data);
    }

    if (state is ForgotPassFailure || state is ForgotPassError) {
      showToastTop(message: 'forgot_password.otp_send_failure'.tr());
    }
  }
}
