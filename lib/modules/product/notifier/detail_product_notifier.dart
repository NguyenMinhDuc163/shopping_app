import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';

import '../../../init.dart';

class DetailProductNotifier {
  ValueNotifier<int> selectedSizeIndex = ValueNotifier(0);
  ValueNotifier<int> selectedColorIndex = ValueNotifier(0);

  final ProductModel product = MockData.mockProduct;

  DetailProductNotifier() {
    _setDefaultSizeColor();
  }

  void _setDefaultSizeColor() {
    bool foundColor = false;

    for (int colorIndex = 0; colorIndex < product.colors.length; colorIndex++) {
      for (int sizeIndex = 0; sizeIndex < product.sizes.length; sizeIndex++) {
        int quantity = product.getQuantity(sizeIndex, colorIndex);
        if (quantity > 0) {
          selectedColorIndex.value = colorIndex;
          selectedSizeIndex.value = sizeIndex;
          foundColor = true;
          break;
        }
      }
      if (foundColor) break;
    }
  }

  void onSizeChanged(int sizeIndex) {
    selectedSizeIndex.value = sizeIndex;
  }

  void onColorChanged(int colorIndex) {
    selectedColorIndex.value = colorIndex;
  }

  int getCurrentQuantity() {
    return product.getQuantity(
      selectedSizeIndex.value,
      selectedColorIndex.value,
    );
  }

  String getQuantityText() {
    final quantity = getCurrentQuantity();

    if (quantity > 5) {
      return "";
    } else if (quantity == 5) {
      return "detail_product.in_stock".tr(namedArgs: {'number': quantity.toString()});
    } else {
      return "detail_product.only_left".tr(namedArgs: {'number': quantity.toString()});
    }
  }

  TextStyle? getQuantityTextStyle() {
    final quantity = getCurrentQuantity();

    if (quantity > 5) {
      return null;
    } else if (quantity == 5) {
      return AppTextStyles.textContent3.copyWith(color: AppColors.coolGray);
    } else {
      return AppTextStyles.textContent3.copyWith(color: AppColors.error);
    }
  }

  bool isSizeAvailable(int sizeIndex) {
    return product.getQuantity(sizeIndex, selectedColorIndex.value) > 0;
  }

  bool isColorAvailable(int colorIndex) {
    return product.getQuantity(selectedSizeIndex.value, colorIndex) > 0;
  }
}