import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/modules/dashboard/screen/dashboard_screen.dart';

import '../../../init.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});
  static const String routeName = '/confirmScreen';
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: "payment.continue_shopping".tr(),
      onClickBottomButton:
          () => Navigator.pushNamed(context, DashboardScreen.routeName),
      screen: Stack(
        children: [
          Image.asset(ImagePath.imagUnion),
          Center(
            child: Padding(
              padding: AppPad.h22v15,
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(ImagePath.imagePhone),
                  AppGap.h30,
                  Text(
                    'payment.order_confirmed'.tr(),
                    style: AppTextStyles.textHeader3,
                  ),
                  Text(
                    'payment.order_confirmation_message'.tr(),
                    style: AppTextStyles.textContent2.copyWith(
                      color: AppColors.coolGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  ButtonWidget(
                    title: "payment.go_to_orders".tr(),
                    titleStyle: AppTextStyles.textContent1.copyWith(
                      color: AppColors.coolGray,
                    ),
                    backgroundColor: AppColors.offWhite,
                    boderRadius: AppBorderRadius.a12,
                    padding: AppPad.v14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
