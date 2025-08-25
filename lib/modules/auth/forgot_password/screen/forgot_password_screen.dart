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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = '/forgotPassword';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPassController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ForgotPassController>();
    controller.setContext(context);
    controller.initializeUsernameListener();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                "forgot_password.title".tr(),
                style: AppTextStyles.textHeader1,
              ),
              SvgPicture.asset(ImagePath.imgForgotPassword),
              AppGap.g2,
              BlocBuilder<ForgotPassCubit, ForgotPassState>(
                buildWhen: (previous, current) {
                  return current is CheckUsernameInProgress ||
                      current is CheckUsernameSuccess ||
                      current is CheckUsernameFailure;
                },
                builder: (context, state) {
                  return TextInputCustom(
                    label: 'sign_up.username'.tr(),
                    controller: controller.userNameController,
                    hintText: "sign_up.enter_username".tr(),
                    validator: (text) {
                      if (state is CheckUsernameSuccess) {
                        return state.isAvailable;
                      }
                      return false;
                    },
                  );
                },
              ),
              AppGap.h100,
              Text(
                'forgot_password.enter_email_for_confirmation'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
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
