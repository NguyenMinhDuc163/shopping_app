import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/modules/cart/widget/icon_widget.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final int minQuantity;
  final int maxQuantity;

  const QuantitySelectorWidget({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    this.maxQuantity = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        GestureDetector(
          onTap: () {
            if (quantity > minQuantity) {
              onQuantityChanged(quantity - 1);
            }
          },
          child: IconWidget(iconPath: FontAwesomeIcons.chevronDown),
        ),
        Text('$quantity', style: AppTextStyles.textContent2.copyWith(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            if (quantity < maxQuantity) {
              onQuantityChanged(quantity + 1);
            }
          },
          child: IconWidget(iconPath: FontAwesomeIcons.chevronUp),
        ),
      ],
    );
  }
}
