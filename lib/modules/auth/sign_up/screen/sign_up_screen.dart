import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_controller.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_cubit.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_state.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signUpScreen';
  @override
  Widget build(BuildContext context) {
    final SignUpController controller = context.read();

    return BlocListener<SignUpCubit, SignUpState>(
      listener: controller.handleListener,
      listenWhen: (previous, next) => previous.runtimeType != next.runtimeType,
      child: _SignUpContent(controller: controller),
    );
  }
}

class _SignUpContent extends StatelessWidget {
  const _SignUpContent({required this.controller});

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    final SignUpState state = context.watch<SignUpCubit>().state;

    final Widget contentWidget = Center(
      child: Padding(
        padding: AppPad.h22v10,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: height_30,
            children: [
              Text('sign_up.title'.tr(), style: AppTextStyles.textHeader1),
              AppGap.h100,
              TextInputCustom(
                label: 'sign_up.username'.tr(),
                controller: controller.usernameController,
                hintText: "sign_up.enter_username".tr(),
                validator: (text) {
                  return text.length >= 4;
                },
              ),
              TextInputCustom(
                label: 'sign_up.password'.tr(),
                controller: controller.passwordController,
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
                controller: controller.emailController,
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
              AppGap.h100,
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        FunctionScreenTemplate(
          titleButtonBottom: 'sign_up.title'.tr(),
          onClickBottomButton: () {
            controller.onSignUp(context);
          },
          screen: contentWidget,
        ),
        if (state is SignUpInProgress)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
