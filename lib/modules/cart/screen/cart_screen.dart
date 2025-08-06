import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/modules/cart/model/product_cart_model.dart';
import 'package:shopping_app/modules/cart/state/cart_state.dart';
import 'package:shopping_app/modules/cart/widget/cart_item_widget.dart';
import 'package:shopping_app/modules/cart/notifier/cart_notifier.dart';
import 'package:shopping_app/modules/cart/widget/delivery_address_widget.dart';
import 'package:shopping_app/modules/cart/widget/order_info_widget.dart';
import 'package:shopping_app/modules/cart/widget/payment_method_widget.dart';
import 'package:shopping_app/modules/cart/widget/title_widget.dart';
import 'package:shopping_app/modules/payment/screen/address_form_screen.dart';
import 'package:shopping_app/modules/payment/screen/new_card_screen.dart';
import 'package:shopping_app/modules/payment/screen/payment_method_screen.dart';

import '../../../init.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier();


    /// ToDo khong can doi mau khi chon san pham
    /// TODO tim hieu  shrinkWrap
    /// TODO chuyen screen thanh customScrollView'
    /// Tang vung an
    return FunctionScreenTemplate(
      onClickBottomButton: () => Navigator.pushNamed(context, AddressFormScreen.routeName),
      title: 'cart.title'.tr(),
      screen: SingleChildScrollView(
        child: Padding(
          padding: AppPad.a16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<CartState>(
                valueListenable: cartNotifier.state,
                builder: (context, cartState, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartState.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartState.cartItems[index];
                      return CartItemWidget(
                        product: product,
                        quantity: cartState.quantities[index],
                        isSelected: cartState.selectedIndex == index,
                        onQuantityChanged: (newQuantity) {
                          cartNotifier.updateQuantity(index, newQuantity);
                        },
                        onTap: () {
                          cartNotifier.updateSelectedIndex(index);
                        },
                        onTapDelete: () {
                          cartNotifier.removeItem(index);
                        },
                      );
                    },
                  );
                },
              ),
              AppGap.h16,
              TitleWidget(
                title: "cart.delivery_address".tr(),
                onTap: () => Navigator.pushNamed(context, AddressFormScreen.routeName),
              ),
              AppGap.h16,
              DeliveryAddressWidget(address: "43, Electronics City Phase 1,\nElectronic City"),
              AppGap.h30,
              TitleWidget(
                title: "cart.payment_method".tr(),
                onTap: () => Navigator.pushNamed(context, PaymentMethodScreen.routeName),
              ),
              AppGap.h12,
              PaymentMethodWidget(
                cardType: "VISA",
                cardName: "Visa Classic",
                cardNumber: "**** 7690",
              ),
              AppGap.h20,
              ValueListenableBuilder<CartState>(
                valueListenable: cartNotifier.state,
                builder: (context, cartState, child) {
                  return OrderInfoWidget(
                    subtotal: cartNotifier.subtotal,
                    deliveryCharge: cartNotifier.deliveryCharge,
                    total: cartNotifier.total,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
