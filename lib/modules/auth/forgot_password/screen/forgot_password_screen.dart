import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_controller.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_state.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = '/forgotPassword';

  @override
  Widget build(BuildContext context) {
    // final ForgotPassController controller = DisposableProvider.of<ForgotPassController>(context,);
    final ForgotPassController controller = context.read(); // TODO C2
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: controller.handleListener,
      listenWhen: (previous, next) => previous.runtimeType != next.runtimeType,
      child: _ForgotPasswordContent(controller: controller),
    );
  }
}

class _ForgotPasswordContent extends StatelessWidget {
  const _ForgotPasswordContent({required this.controller});

  final ForgotPassController controller;

  @override
  Widget build(BuildContext context) {
    final ForgotPassState state = context.watch<ForgotPassCubit>().state;

    final Widget contentWidget = Padding(
      padding: AppPad.h22v10,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: height_30,
            children: [
              Text("forgot_password.title".tr(), style: AppTextStyles.textHeader1),
              SvgPicture.asset(ImagePath.imgForgotPassword),
              AppGap.g2,
              TextInputCustom(
                label: 'sign_up.username'.tr(),
                controller: controller.userNameController,
                hintText: "sign_up.enter_username".tr(),
                validator: (text) {
                  return Validators.isValidEmail(text);
                },
              ),
              AppGap.h100,
              Text(
                'forgot_password.enter_email_for_confirmation'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.textContent3.copyWith(color: AppColors.coolGray),
              ),
              AppGap.g1,
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        FunctionScreenTemplate(
          titleButtonBottom: "forgot_password.confirm_mail".tr(),
          onClickBottomButton: () {
            controller.onSendOpt(context);
          },

          screen: contentWidget,
        ),
        if (state is ForgotPassInProgress)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
