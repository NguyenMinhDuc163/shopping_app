import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_dimension.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({required this.title, required this.iconPath});
final String title;
final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: width_8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(iconPath),
        Text(
          title,
          style: AppTextStyles.textContent1.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
