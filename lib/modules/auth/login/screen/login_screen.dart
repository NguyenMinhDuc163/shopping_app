import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/values/login_type.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/login/bloc/login_controller.dart';
import 'package:shopping_app/modules/auth/login/bloc/login_cubit.dart';
import 'package:shopping_app/modules/auth/login/widget/title_widget.dart';
import 'package:shopping_app/modules/auth/sign_in/screen/sign_in_screen.dart';
import 'package:shopping_app/modules/auth/sign_up/screen/sign_up_screen.dart';
import 'package:shopping_app/modules/auth/widgets/text_span_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    final LoginController controller = context.read(); // TODO C2

    return BlocListener<LoginCubit, LoginState>(
      listener: controller.handleListener,
      child: _LoginContent(controller: controller),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final LoginState state = context.watch<LoginCubit>().state;

    final Widget contentWidget = AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: AppColors.lavenderColor,
        systemNavigationBarContrastEnforced: false,
      ),
      child: FunctionScreenTemplate(
        onClickBottomButton: () {
          Navigator.pushNamed(context, SignUpScreen.routeName);
        },
        titleButtonBottom: "login_screen.create_account".tr(),
        isShowBottomButton: true,
        isShowAppBar: false,
        screen: Padding(
          padding: AppPad.h22v10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 12,
            children: [
              Text(
                "login_screen.get_started".tr(),
                style: AppTextStyles.textHeader1,
              ),
              Expanded(flex: 185, child: SizedBox.shrink()),
              Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  ButtonWidget(
                    titleWidget: TitleWidget(
                      title: "Facebook",
                      iconPath: IconPath.iconFacebook,
                    ),
                    onPressed: () {
                      controller.onLogin(context, LoginType.facebook);
                    },
                    backgroundColor: AppColors.deepBlue,
                    padding: AppPad.v14,
                    boderRadius: BorderRadius.all(AppRadius.c10),
                  ),
                  ButtonWidget(
                    titleWidget: TitleWidget(
                      title: "Twitter",
                      iconPath: IconPath.iconTwitter,
                    ),
                    onPressed: () {
                      controller.onLogin(context, LoginType.twitter);
                    },
                    backgroundColor: AppColors.skyBlue,
                    padding: AppPad.v14,
                    boderRadius: BorderRadius.all(AppRadius.c10),
                  ),
                  ButtonWidget(
                    titleWidget: TitleWidget(
                      title: "Google",
                      iconPath: IconPath.iconGoogle,
                    ),
                    onPressed: () {
                      controller.onLogin(context, LoginType.google);
                    },
                    backgroundColor: AppColors.crimson,
                    padding: AppPad.v14,
                    boderRadius: BorderRadius.all(AppRadius.c10),
                  ),
                ],
              ),

              Expanded(flex: 204, child: SizedBox.shrink()),
              TextSpanWidget(
                normalText: "${'login_screen.already_have_account'.tr()} ",
                clickableText: 'login_screen.signin'.tr(),
                onTap:
                    () => Navigator.pushNamed(context, SignInScreen.routeName),
              ),
              // AppGap.g2,
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        contentWidget,
        if (state is LoginInProgress)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
