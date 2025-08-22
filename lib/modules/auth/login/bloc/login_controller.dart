import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/values/login_type.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/login/bloc/login_cubit.dart';
import 'package:shopping_app/modules/home/screen/home_screen.dart';

class LoginController extends Disposable {
  onLogin(BuildContext context, LoginType type) {
    context.read<LoginCubit>().onLoginSocial();
  }

  handleListener(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }

    if (state is LoginFailure) {
      showToastTop(message: 'login.failed'.tr());
      throw Exception(state.message);

    }
  }

  @override
  void dispose() {}
}
