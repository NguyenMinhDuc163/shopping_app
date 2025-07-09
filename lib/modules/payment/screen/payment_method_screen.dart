import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/modules/payment/screen/new_card_screen.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../../init.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});
  static const String routeName = '/paymentMethodScreen';
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  TextEditingController cardOwnerController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController cvvController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: "payment.save_card".tr(),
      title: "payment.title".tr(),
      onClickBottomButton:
          () => Navigator.pushNamed(context, NewCardScreen.routeName),
      screen: Padding(
        padding: AppPad.h22v15,
        child: Column(
          spacing: 20,
              children: [
                SizedBox(
                  height: 185,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: MockData.cards.length,
                    itemBuilder: (context, index) {
                      final card = MockData.cards[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: CreditCardUi(
                          width: 300,
                          cardHolderFullName: card.cardHolderFullName,
                          cardNumber: card.cardNumber,
                          validThru: card.validThru,
                          cardType: CardType.giftCard,
                          // topLeftColor: card.backgroundColor ?? Colors.blue,
                          backgroundDecorationImage: DecorationImage(
                            image: AssetImage(ImagePath.imgCardBackground),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppGap.h1,
                ButtonWidget(
                  height: 60,
                  backgroundColor: AppColors.colorF6F2FF,
                  borderColor: AppColors.lavenderColor,
                  boderRadius: AppBorderRadius.a12,
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Icon(Icons.add_box_outlined, color: AppColors.lavenderColor),
                      Text(
                        "payment.add_new_card".tr(),
                        style: AppTextStyles.textContent1.copyWith(
                          color: AppColors.lavenderColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'payment.save_card_info'.tr(),
                      style: AppTextStyles.textContent2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SwitchBottomWidget(),
                  ],
                ),
              ],
        ),
      ),
    );
  }
}
