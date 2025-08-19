import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_controller.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_cubit.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/reset_pass_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const String routeName = '/changePassword';
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    return DisposableProvider(

        create: (BuildContext context) {
          return ResetPassController();
        },

        builder: (context, child){
          final ResetPassController controller = DisposableProvider.of<ResetPassController>(context,);
          return BlocListener<ResetPassCubit, ResetPassState>(
              listener: controller.handleListener,
              listenWhen: (previous, next) => previous.runtimeType != next.runtimeType,
              child: _buildContent(context, controller));
        });
  }

  Widget _buildContent(BuildContext context, ResetPassController controller){
    return BlocBuilder<ResetPassCubit, ResetPassState>(
      builder: (context,state){
        final initialWidget = FunctionScreenTemplate(
          titleButtonBottom: 'forgot_password.reset_password'.tr(),
          onClickBottomButton: () {
            controller.onResetPassword(context);
          },
          screen: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: AppPad.h22v10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: height_30,
                  children: [
                    Text(
                      'forgot_password.new_password'.tr(),
                      style: AppTextStyles.textHeader1,
                    ),
                    AppGap.h100,
                    TextInputCustom(
                      label: 'sign_up.password'.tr(),
                      controller: controller.passwordController,
                      hintText: "sign_up.enter_password".tr(),
                      suffixIcon: Text(
                        "sign_up.strong".tr(),
                        style: AppTextStyles.textContent3.copyWith(
                          color: AppColors.limeGreen,
                        ),
                      ),
                      validator: (text) {
                        return text.length >= 8;
                      },
                    ),
                    TextInputCustom(
                      label: 'forgot_password.confirm_password'.tr(),
                      controller: controller.confirmPasswordController,
                      hintText: "forgot_password.enter_new_password".tr(),
                      validator: (text) {
                        return text.length >= 4;
                      },
                    ),

                    AppGap.h100,
                    Text(
                      'forgot_password.enter_new_password'.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textContent3.copyWith(
                        color: AppColors.coolGray,
                      ),
                    ),
                    AppGap.g1
                  ],
                ),
              ),
            ),
          ),
        );
        final Widget inProgressWidget = Center(
          child: CircularProgressIndicator(),
        );

        return (switch (state) {
          ResetPassInitial() => initialWidget,
          ResetPassInProgress() => inProgressWidget,
          ResetPassSuccess() => initialWidget,
          ResetPassFailure() => initialWidget,
          ResetPassError() => initialWidget,
        });
      },
    );
  }
}
