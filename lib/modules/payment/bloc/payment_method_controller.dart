import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/material.dart';

class PaymentMethodController extends Disposable {
  ValueNotifier<TextEditingController> cardOwnerController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> cardNumberController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> expController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> cvvController = ValueNotifier(TextEditingController());
  @override
  void dispose() {
    cardOwnerController.dispose();
    cardNumberController.dispose();
    expController.dispose();
    cvvController.dispose();
  }
}
