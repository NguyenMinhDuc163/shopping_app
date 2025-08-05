import 'package:shopping_app/modules/cart/model/product_cart_model.dart';

class CartState {
  final int selectedIndex;
  final List<int> quantities;
  final List<ProductCartModel> cartItems;

  CartState({
    required this.selectedIndex,
    required this.quantities,
    required this.cartItems,
  });

  CartState copyWith({
    int? selectedIndex,
    List<int>? quantities,
    List<ProductCartModel>? cartItems,
  }) {
    return CartState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      quantities: quantities ?? this.quantities,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}