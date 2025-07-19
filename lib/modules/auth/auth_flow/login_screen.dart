import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/auth_flow/sign_in_screen.dart';
import 'package:shopping_app/modules/auth/auth_flow/sign_up_screen.dart';
import 'package:shopping_app/modules/auth/widgets/text_span_widget.dart';
import 'package:shopping_app/modules/dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      onClickBottomButton: () {
        Navigator.pushNamed(context, SignUpScreen.routeName);
      },
      titleButtonBottom: "login_screen.create_account".tr(),
      screen: Padding(
        padding: AppPad.h22v10,
        child: LayoutBuilder(
          builder: (context, constraints) {
            const double figmaWidth = 375;
            const double figmaHeight = 812;

            final double scaleW = constraints.maxWidth / figmaWidth;
            final double scaleH = constraints.maxHeight / figmaHeight;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 12,
              children: [
                Text(
                  "login_screen.get_started".tr(),
                  style: AppTextStyles.textHeader1,
                ),
                // Expanded(flex: 185, child: SizedBox.shrink()),
                Expanded(
                  child: Align(
                    alignment: Alignment(0, 204/559),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 20,
                      children: [
                        ButtonWidget(
                          titleWidget: _buildTitle(
                            title: "Facebook",
                            iconPath: IconPath.iconFacebook,
                          ),
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                DashboardScreen.routeName,
                              ),
                          backgroundColor: AppColors.deepBlue,
                          padding: AppPad.v14,
                          boderRadius: BorderRadius.all(AppRadius.c10),
                        ),
                        ButtonWidget(
                          titleWidget: _buildTitle(
                            title: "Twitter",
                            iconPath: IconPath.iconTwitter,
                          ),
                          onPressed: () {},
                          backgroundColor: AppColors.skyBlue,
                          padding: AppPad.v14,
                          boderRadius: BorderRadius.all(AppRadius.c10),
                        ),
                        ButtonWidget(
                          titleWidget: _buildTitle(
                            title: "Google",
                            iconPath: IconPath.iconGoogle,
                          ),
                          onPressed: () {},
                          backgroundColor: AppColors.crimson,
                          padding: AppPad.v14,
                          boderRadius: BorderRadius.all(AppRadius.c10),
                        ),
                      ],
                    ),
                  ),
                ),

                // Expanded(flex: 204, child: SizedBox.shrink()),
                TextSpanWidget(
                  normalText: "${'login_screen.already_have_account'.tr()} ",
                  clickableText: 'login_screen.signin'.tr(),
                  onTap:
                      () =>
                          Navigator.pushNamed(context, SignInScreen.routeName),
                ),
                // AppGap.g2,
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle({required String title, required String iconPath}) {
    return Row(
      spacing: width_8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(iconPath),
        Text(
          title,
          style: AppTextStyles.textContent1.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
