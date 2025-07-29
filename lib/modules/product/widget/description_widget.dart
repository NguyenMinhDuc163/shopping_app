import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';

import '../../../init.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({super.key, this.product});
  final ProductModel? product;

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final description = widget.product?.description ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "review.description".tr(),
          style: AppTextStyles.textContent1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: AppTextStyles.textContent3.copyWith(
                  color: AppColors.coolGray,
                ),
                maxLines: _isExpanded ? null : 3,
              ),
              if (description.length > 80)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _isExpanded ? "Show Less" : "Read More..",
                    style: AppTextStyles.textContent3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
