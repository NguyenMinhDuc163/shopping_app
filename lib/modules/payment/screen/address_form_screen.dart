import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/modules/payment/screen/payment_method_screen.dart';

import '../../../init.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});
  static const String routeName = '/addressFormScreen';
  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // todo controllers extends disposable controllers => nhom 16 - 20

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      titleButtonBottom: "payment.save_address".tr(),
      title: "payment.address".tr(),
      onClickBottomButton: () => Navigator.pushNamed(context, PaymentMethodScreen.routeName),
      screen: Padding(
        padding: AppPad.h22v15,
        child: Column(
          spacing: 20,
          children: [
            TextInputCustom(
              controller: nameController,
              fillColor: true,
              label: 'payment.name'.tr(),
              hintText: "Hemendra Mali",
              titleStyle: AppTextStyles.textContent1.copyWith(fontWeight: FontWeight.bold),
              borderRadius: AppBorderRadius.a8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20,
              children: [
                Expanded(
                  child: TextInputCustom(
                    controller: countryController,
                    fillColor: true,
                    label: 'payment.country'.tr(),
                    hintText: "India",
                    titleStyle: AppTextStyles.textContent1.copyWith(fontWeight: FontWeight.bold),
                    borderRadius: AppBorderRadius.a8,
                  ),
                ),
                Expanded(
                  child: TextInputCustom(
                    controller: cityController,
                    fillColor: true,
                    label: 'payment.city'.tr(),
                    hintText: "Bangalore",
                    titleStyle: AppTextStyles.textContent1.copyWith(fontWeight: FontWeight.bold),
                    borderRadius: AppBorderRadius.a8,
                  ),
                ),
              ],
            ),
            TextInputCustom(
              controller: phoneController,
              fillColor: true,
              label: 'payment.phone_number'.tr(),
              hintText: "+91-800 301 0108",
              titleStyle: AppTextStyles.textContent1.copyWith(fontWeight: FontWeight.bold),
              borderRadius: AppBorderRadius.a8,
            ),
            TextInputCustom(
              controller: addressController,
              fillColor: true,
              label: 'payment.address'.tr(),
              hintText: "43, Electronics City Phase 1, Electronic City",
              titleStyle: AppTextStyles.textContent1.copyWith(fontWeight: FontWeight.bold),
              borderRadius: AppBorderRadius.a8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'payment.save_as_primary_address'.tr(),
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
