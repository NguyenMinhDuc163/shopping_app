import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/modules/cart/model/product_cart_model.dart';
import 'package:shopping_app/modules/cart/state/cart_state.dart';



class CartNotifier extends ChangeNotifier {
  final ValueNotifier<CartState> _state = ValueNotifier<CartState>(
    CartState(
      selectedIndex: 1,
      quantities: [1, 1],
      cartItems: MockData.cartProduct,
    ),
  );

  ValueNotifier<CartState> get state => _state;


  void updateSelectedIndex(int index) {
    _state.value = _state.value.copyWith(selectedIndex: index);
  }

  void updateQuantity(int index, int newQuantity) {
    final newQuantities = List<int>.from(_state.value.quantities);
    newQuantities[index] = newQuantity;
    _state.value = _state.value.copyWith(quantities: newQuantities);
  }

  void removeItem(int index) {
    final newCartItems = List<ProductCartModel>.from(_state.value.cartItems);
    final newQuantities = List<int>.from(_state.value.quantities);

    newCartItems.removeAt(index);
    newQuantities.removeAt(index);

    int newSelectedIndex = _state.value.selectedIndex;
    if (newSelectedIndex >= newCartItems.length) {
      newSelectedIndex = newCartItems.length - 1;
    }

    _state.value = _state.value.copyWith(
      cartItems: newCartItems,
      quantities: newQuantities,
      selectedIndex: newSelectedIndex,
    );
  }


  double get subtotal {
    double total = 0;
    for (int i = 0; i < _state.value.cartItems.length; i++) {
      total += _state.value.cartItems[i].price * _state.value.quantities[i];
    }
    return total;
  }

  double get deliveryCharge => 10.0;

  double get total => subtotal + deliveryCharge;

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }
}
