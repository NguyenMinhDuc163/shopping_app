import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/material.dart';

class AddressFormController extends Disposable {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    phoneController.dispose();
    addressController.dispose();
  }
}
