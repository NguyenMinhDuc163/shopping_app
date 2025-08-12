import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class OrderInfoWidget extends StatelessWidget {
  final double subtotal;
  final double deliveryCharge;
  final double total;

  const OrderInfoWidget({
    super.key,
    required this.subtotal,
    required this.deliveryCharge,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("cart.order_info".tr(), style: AppTextStyles.textHeader3),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "cart.subtotal".tr(),
              style: AppTextStyles.textContent1.copyWith(
                color: AppColors.coolGray,
              ),
            ),
            Text(
              "\$${subtotal.toStringAsFixed(0)}",
              style: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "cart.delivery_charge".tr(),
              style: AppTextStyles.textContent1.copyWith(
                color: AppColors.coolGray,
              ),
            ),
            Text(
              "\$${deliveryCharge.toStringAsFixed(0)}",
              style: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "cart.total".tr(),
              style: AppTextStyles.textContent1.copyWith(
                color: AppColors.coolGray,
              ),
            ),
            Text(
              "\$${total.toStringAsFixed(0)}",
              style: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
