import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_dimension.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_radius.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/modules/auth/screens/sign_up_screen.dart';
import 'package:shopping_app/modules/dashboard/dashboard_screen.dart';
import 'package:shopping_app/modules/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/LoginScreen';

    @override
    Widget build(BuildContext context) {
      return FunctionScreenTemplate(
        onClickBottomButton: (){
          Navigator.pushNamed(context, SignUpScreen.routeName);
        },
          titleButtonBottom: "login_screen.create_account".tr(),
        screen: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Text("login_screen.get_started".tr(), style: AppTextStyles.text.copyWith(fontSize: 28, fontWeight: FontWeight.bold),),
            Spacer(),
            ButtonWidget(titleWidget: _buildTitle(title: "Facebook", iconPath: IconPath.iconFacebook), onPressed: () {}, backgroundColor: AppColors.deepBlue, margin: AppPad.h24, height: height_56, boderRadius: BorderRadius.all(AppRadius.c10),),
            ButtonWidget(titleWidget: _buildTitle(title: "Twitter", iconPath: IconPath.iconTwitter), onPressed: () {}, backgroundColor: AppColors.skyBlue, margin: AppPad.h24, height: height_56, boderRadius: BorderRadius.all(AppRadius.c10),),
            ButtonWidget(titleWidget: _buildTitle(title: "Google", iconPath: IconPath.iconGoogle), onPressed: () {}, backgroundColor: AppColors.crimson, margin: AppPad.h24, height: height_56, boderRadius: BorderRadius.all(AppRadius.c10),),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('login_screen.already_have_account'.tr(), style: AppTextStyles.textContent1.copyWith(color: AppColors.coolGray)),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                    child: Text('login_screen.signin'.tr().tr(), style: AppTextStyles.textContent1.copyWith(fontWeight: FontWeight.bold)))
              ],
            ),
            AppGap.g2
          ],
        )
      );
    }

    Widget _buildTitle({required String title,required String iconPath}){
      return Row(
        spacing: width_8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          Text(title, style: AppTextStyles.textContent1.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),)
        ],
      );
    }
  }