import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';

import '../../../init.dart';

class ProductInfoWidget extends StatelessWidget {
  final ProductModel? product;

  const ProductInfoWidget({super.key, this.product});

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
                product?.subTitle ?? "Brand",
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product?.name ?? "Product Name",
                style: AppTextStyles.textHeader3,
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                children: [
                  Text(
                    "review.price".tr(),
                    style: AppTextStyles.textContent3.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                  if (product?.discountPercentage != 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorC64B4D,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "-${product!.discountPercentage}%",
                        style: AppTextStyles.textContent3.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                "\$${product?.price.toStringAsFixed(2) ?? "0.00"}",
                style: AppTextStyles.textHeader3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
