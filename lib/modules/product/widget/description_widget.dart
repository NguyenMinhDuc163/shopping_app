import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../init.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        Text(
          "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with Read More..",
          style: AppTextStyles.textContent3.copyWith(
            color: AppColors.coolGray,
          ),
        ),
      ],
    );
  }
}
