import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/sliver_pad_to_box.dart';
import 'package:shopping_app/modules/cart/state/cart_state.dart';
import 'package:shopping_app/modules/cart/widget/cart_item_widget.dart';
import 'package:shopping_app/modules/cart/notifier/cart_notifier.dart';
import 'package:shopping_app/modules/cart/widget/delivery_address_widget.dart';
import 'package:shopping_app/modules/cart/widget/order_info_widget.dart';
import 'package:shopping_app/modules/cart/widget/payment_method_widget.dart';
import 'package:shopping_app/modules/cart/widget/title_widget.dart';
import 'package:shopping_app/modules/payment/screen/address_form_screen.dart';
import 'package:shopping_app/modules/payment/screen/payment_method_screen.dart';

import '../../../init.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier();

    /// ToDo khong can doi mau khi chon san pham
    /// TODO tim hieu shrinkWrap
    /// TODO chuyen screen thanh customScrollView'
    /// TODO vung an
    return FunctionScreenTemplate(
      onClickBottomButton: () => Navigator.pushNamed(context, AddressFormScreen.routeName),
      title: 'cart.title'.tr(),
      screen: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: AppPad.h16,
            sliver: ValueListenableBuilder<CartState>(
              valueListenable: cartNotifier.state,
              builder: (context, cartState, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = cartState.cartItems[index];
                    return CartItemWidget(
                      product: product,
                      quantity: cartState.quantities[index],
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
                  }, childCount: cartState.cartItems.length),
                );
              },
            ),
          ),

          SliverPadding(padding: AppPad.h16, sliver: AppGap.sh16),
          SliverPadToBox(
            padding: AppPad.h16,
            child: TitleWidget(
              title: "cart.delivery_address".tr(),
              onTap: () => Navigator.pushNamed(context, AddressFormScreen.routeName),
            ),
          ),
          SliverPadding(padding: AppPad.h16, sliver: AppGap.sh16),
          SliverPadToBox(
            padding: AppPad.h16,
            child: DeliveryAddressWidget(address: "43, Electronics City Phase 1,\nElectronic City"),
          ),

          SliverPadding(padding: AppPad.h16, sliver: AppGap.sh30),
          SliverPadToBox(
            padding: AppPad.h16,
            child: TitleWidget(
              title: "cart.payment_method".tr(),
              onTap: () => Navigator.pushNamed(context, PaymentMethodScreen.routeName),
            ),
          ),
          SliverPadding(padding: AppPad.h16, sliver: AppGap.sh12),
          SliverPadToBox(
            padding: AppPad.h16,
            child: PaymentMethodWidget(
              cardType: "VISA",
              cardName: "Visa Classic",
              cardNumber: "**** 7690",
            ),
          ),

          SliverPadding(padding: AppPad.h16, sliver: AppGap.sh20),
          SliverPadToBox(
            padding: AppPad.h16,
            child: ValueListenableBuilder<CartState>(
              valueListenable: cartNotifier.state,
              builder: (context, cartState, child) {
                return OrderInfoWidget(
                  subtotal: cartNotifier.subtotal,
                  deliveryCharge: cartNotifier.deliveryCharge,
                  total: cartNotifier.total,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
