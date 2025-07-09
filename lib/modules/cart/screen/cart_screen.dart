import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/modules/payment/screen/address_form_screen.dart';

import '../../../init.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String routeName = '/cartScreen';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int selectedIndex = 1;

  List<int> quantities = [1, 1];

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      onClickBottomButton:
          () => Navigator.pushNamed(context, AddressFormScreen.routeName),
      title: 'cart.title'.tr(),
      screen: SingleChildScrollView(
        child: Padding(
          padding: AppPad.a16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: MockData.cartProduct.length,
                itemBuilder: (context, index) {
                  final product = MockData.cartProduct[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color:
                            selectedIndex == index
                                ? AppColors.lightGray
                                : AppColors.colorFEFEFE,
                        borderRadius: AppBorderRadius.a12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: AppPad.a8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(product.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          AppGap.w8,
                          Expanded(
                            child: Padding(
                              padding: AppPad.h8v4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  Text(
                                    product.name,
                                    style: AppTextStyles.textContent2.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$${product.price} (+\$${product.tax} Tax)",
                                    style: AppTextStyles.textContent2.copyWith(
                                      color: AppColors.coolGray,
                                    ),
                                  ),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (quantities[index] > 1) {
                                            setState(() {
                                              quantities[index]--;
                                            });
                                          }
                                        },
                                        child: _buildIcon(
                                          icon: FontAwesomeIcons.chevronDown,
                                        ),
                                      ),
                                      Text(
                                        '${quantities[index]}',
                                        style: AppTextStyles.textContent2
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            quantities[index]++;
                                          });
                                        },
                                        child: _buildIcon(
                                          icon: FontAwesomeIcons.chevronUp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _buildIcon(icon: FontAwesomeIcons.trashCan)
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "cart.delivery_address".tr(),
                    style: AppTextStyles.textHeader3,
                  ),
                  Icon(Icons.chevron_right, color: Colors.black),
                ],
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F2FF),
                      borderRadius: AppBorderRadius.a12,
                    ),
                    child: Center(
                      child: Icon(Icons.location_on, color: Color(0xFFFF7A00)),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "43, Electronics City Phase 1,\nElectronic City",
                          style: AppTextStyles.textContent2.copyWith(
                            color: AppColors.coolGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle, color: Colors.green, size: 30),
                ],
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "cart.payment_method".tr(),
                    style: AppTextStyles.textHeader3,
                  ),
                  Icon(Icons.chevron_right, color: Colors.black),
                ],
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "VISA",
                        style: TextStyle(
                          color: Color(0xFF2A4BA0),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Visa Classic", style: AppTextStyles.textContent2),
                        Text(
                          "**** 7690",
                          style: AppTextStyles.textContent3.copyWith(
                            color: AppColors.coolGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle, color: Colors.green, size: 30),
                ],
              ),
              SizedBox(height: 20),

              Text("cart.order_info".tr(), style: AppTextStyles.textHeader3),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "cart.subtotal".tr(),
                    style: AppTextStyles.textContent1.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                  Text(
                    "\$110",
                    style: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "cart.delivery_charge".tr(),
                    style: AppTextStyles.textContent1.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                  Text(
                    "\$10",
                    style: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "cart.total".tr(),
                    style: AppTextStyles.textContent1.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                  Text(
                    "\$120",
                    style: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildIcon({required IconData icon}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.colorDEDEDE, width: 1.5),
        color: Colors.white,
      ),
      child: Icon(icon, size: 15, color: AppColors.coolGray),
    );
  }
}
