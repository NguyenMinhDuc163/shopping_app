import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/material.dart';

class AddressFormController extends Disposable {
  ValueNotifier<TextEditingController> nameController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> countryController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> cityController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> phoneController = ValueNotifier(TextEditingController());
  ValueNotifier<TextEditingController> addressController = ValueNotifier(TextEditingController());

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    phoneController.dispose();
    addressController.dispose();
  }
}
