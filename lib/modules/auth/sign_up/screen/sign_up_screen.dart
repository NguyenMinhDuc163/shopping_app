import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/core/widgets/toast.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_state.dart';
import 'package:shopping_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_cubit.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_state.dart';
import 'package:shopping_app/utils/helpers/validators.dart';
import 'package:shopping_app/init.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isSwitched = false;

  _onSignUp() {
    if (!_isValidateForm()) return;

    context.read<SignUpCubit>().onRegisterStarted(
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
    );
  }

  bool _isValidateForm() {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text.isEmpty) {
      showToastTop(message: "sign_up.required_fields".tr());
      return false;
    }
    if (passwordController.text.length < 8) {
      showToastTop(message: "sign_up.password_length".tr());
      return false;
    }
    if (!Validators.isValidEmail(emailController.text)) {
      showToastTop(message: "sign_up.invalid_email".tr());
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: 'sign_up.title'.tr(),
      onClickBottomButton: _onSignUp,
      screen: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.pushNamed(context, SignInScreen.routeName);
          }

          if (state is SignUpFailure) {
            showToastTop(message: 'sign_up.register_failure'.tr());
          }

          if (state is SignUpError) {
            showToastTop(message: 'sign_up.register_failure'.tr());
          }
        },
        listenWhen: (previous, next) => previous.runtimeType != next.runtimeType,
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final initialWidget = Center(
          child: Padding(
            padding: AppPad.h22v10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: height_30,
              children: [
                Text('sign_up.title'.tr(), style: AppTextStyles.textHeader1),
                Spacer(),
                TextInputCustom(
                  label: 'sign_up.username'.tr(),
                  controller: usernameController,
                  hintText: "sign_up.enter_username".tr(),
                  validator: (text) {
                    return text.length >= 4;
                  },
                ),
                TextInputCustom(
                  label: 'sign_up.password'.tr(),
                  controller: passwordController,
                  hintText: "sign_up.enter_password".tr(),
                  suffixIcon: Text(
                    "sign_up.strong".tr(),
                    style: AppTextStyles.textContent3.copyWith(color: AppColors.limeGreen),
                  ),
                  validator: (text) {
                    return text.length >= 8;
                  },
                ),
                TextInputCustom(
                  label: 'Email',
                  controller: emailController,
                  hintText: "sign_up.enter_email".tr(),
                  validator: (text) {
                    return Validators.isValidEmail(text);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("sign_up.remember_me".tr(), style: AppTextStyles.textContent3),
                    SwitchBottomWidget(onChanged: (value) {}),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        );
        final Widget inProgressWidget = Center(child: CircularProgressIndicator());
        return (switch (state) {
          SignUpInitial() => initialWidget,
          SignUpInProgress() => inProgressWidget,
          SignUpSuccess() => initialWidget,
          SignUpFailure() => initialWidget,
          SignUpError() => initialWidget,
        });
      },
    );
  }
}
