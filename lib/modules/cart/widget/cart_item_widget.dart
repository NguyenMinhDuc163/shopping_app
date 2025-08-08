import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/modules/cart/model/product_cart_model.dart';
import 'package:shopping_app/modules/cart/widget/icon_widget.dart';
import 'package:shopping_app/modules/cart/widget/quantity_selector_widget.dart';

class CartItemWidget extends StatelessWidget {
  final ProductCartModel product;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback? onTap;
  final VoidCallback? onTapDelete;

  const CartItemWidget({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    this.onTap,
    this.onTapDelete,
  });

  // TODO thay itemWidget thanh  AssetIconSvg
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    QuantitySelectorWidget(
                      quantity: quantity,
                      onQuantityChanged: onQuantityChanged,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onTapDelete,
              child: IconWidget(iconPath: FontAwesomeIcons.trashCan),
            ),
          ],
        ),
      ),
    );
  }
} 