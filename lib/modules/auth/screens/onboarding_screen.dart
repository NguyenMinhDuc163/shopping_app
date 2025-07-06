import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/image_path.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_dimension.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/modules/dashboard/dashboard_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/onboardingScreen';
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowAppBar: false,
      background: Image.asset(ImagePath.imgOnboardBackgourd, fit: BoxFit.cover),
      isShowBottomButton: false,
      screen: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(ImagePath.imgPersion),
          Padding(
            padding: AppPad.h22v10,
            child: _cardWidget(
              context: context,
              onMen: () => Navigator.pushNamed(context, DashboardScreen.routeName),
              onWomen: () => Navigator.pushNamed(context, DashboardScreen.routeName),
              onSkip: () => Navigator.pushNamed(context, DashboardScreen.routeName),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardWidget({
    required BuildContext context,
    required VoidCallback onWomen,
    required VoidCallback onMen,
    required VoidCallback onSkip,
  }) {
    return Container(
      padding: AppPad.a20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadius.a14,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        spacing: height_16,
        children: [
          Text(
            'onboarding.slogan'.tr(),
            style: AppTextStyles.textHeader3,
            textAlign: TextAlign.center,
          ),
          Text(
            'onboarding.description'.tr(),
            style: AppTextStyles.textContent2.copyWith(
              color: AppColors.coolGray,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            spacing: width_16,
            children: [
              Expanded(
                child: ButtonWidget(
                  title: "onboarding.women".tr(),
                  height: height_64,
                  boderRadius: AppBorderRadius.a14,
                  backgroundColor: AppColors.lightGray,
                  titleStyle: AppTextStyles.textContent1.copyWith(
                    color: AppColors.coolGray,
                  ),
                  onPressed: onWomen,
                ),
              ),
              Expanded(
                child: ButtonWidget(
                  title: "onboarding.men".tr(),
                  height: height_64,
                  boderRadius: AppBorderRadius.a14,
                  titleStyle: AppTextStyles.textContent1.copyWith(
                    color: AppColors.white,
                  ),
                  onPressed: onMen,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onSkip,
            child: Text(
              'onboarding.skip'.tr(),
              style: AppTextStyles.textContent1.copyWith(
                color: AppColors.coolGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
