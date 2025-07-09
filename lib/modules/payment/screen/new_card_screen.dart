import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/modules/payment/screen/confirm_screen.dart';

import '../../../init.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});
  static const String routeName = '/newCardScreen';
  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  TextEditingController cardOwnerController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: "payment.add_card".tr(),
      title: "payment.add_new_card".tr(),
      onClickBottomButton: () => Navigator.pushNamed(context, ConfirmScreen.routeName),
      screen: Padding(
        padding: AppPad.h22v15,
        child: Column(
          spacing: 20,
          children: [
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ButtonWidget(
                    titleWidget: Image.asset(IconPath.iconMaster),
                    backgroundColor: AppColors.lightGray,
                    height: 60,
                    boderRadius: AppBorderRadius.a12,
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    titleWidget: Image.asset(IconPath.iconPaypal),
                    backgroundColor: AppColors.lightGray,
                    height: 60,
                    boderRadius: AppBorderRadius.a12,
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    titleWidget: Image.asset(IconPath.iconBank),
                    backgroundColor: AppColors.lightGray,
                    height: 60,
                    boderRadius: AppBorderRadius.a12,
                  ),
                ),
              ],
            ),
            TextInputCustom(
              controller: cardOwnerController,
              fillColor: true,
              label: 'payment.card_owner'.tr(),
              hintText: "Hemendra Mali",
              titleStyle: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
              borderRadius: AppBorderRadius.a8,
            ),
            TextInputCustom(
              controller: cardNumberController,
              fillColor: true,
              label: 'payment.card_number'.tr(),
              hintText: "5254 7634 8734 7690",
              titleStyle: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
              borderRadius: AppBorderRadius.a8,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20,
              children: [
                Expanded(
                  child: TextInputCustom(
                    controller: expController,
                    fillColor: true,
                    label: 'EXP'.tr(),
                    hintText: "07/25",
                    titleStyle: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: AppBorderRadius.a8,
                  ),
                ),
                Expanded(
                  child: TextInputCustom(
                    controller: cvvController,
                    fillColor: true,
                    label: 'CVV'.tr(),
                    hintText: "123",
                    titleStyle: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: AppBorderRadius.a8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
