import 'package:flutter/material.dart';

import '../../../init.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPad.a16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Men's Printed Pullover Hoodie",
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Nike Club Fleece",
                style: AppTextStyles.textHeader3,
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\$999",
                style: AppTextStyles.textHeader3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
