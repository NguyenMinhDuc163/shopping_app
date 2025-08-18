import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/initial/screen/onboarding_screen.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_cubit.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_state.dart';

class SignInController extends Disposable {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isSwitched = ValueNotifier(false);

  SignInController({Map<String, String>? prefillData}) {
    if (prefillData != null) {
      _prefillData(prefillData);
    }
  }

  void _prefillData(Map<String, String> data) {
    if (data['username'] != null) {
      usernameController.text = data['username']!;
    }
  }

  handleListener(BuildContext context, SignInState state) {
    if (state is SignInSuccess) {
      Navigator.pushNamed(context, OnboardingScreen.routeName);
    }

    if (state is SignInFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('login.failed'.tr()),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  onSignIn(BuildContext context) {
    if (usernameController.text == '' || passwordController.text == '') {
      showToastTop(message: "sign_up.required_fields".tr());
    }
    context.read<SignInCubit>().onLoginStarted(
      username: usernameController.text,
      password: passwordController.text,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
