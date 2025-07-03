import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_dimension.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    this.title,
    this.titleStyle,
    this.titleWidget,
    required this.onPressed,
    this.backgroundColor = AppColors.lavenderColor,
    this.boderRadius = BorderRadius.zero,
    this.width = double.infinity,
    this.height = 80,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });
  String? title;
  TextStyle? titleStyle;
  Widget? titleWidget;
  Color backgroundColor;
  BorderRadiusGeometry boderRadius;
  Function onPressed;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: padding,
        margin: margin,
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: boderRadius,
        ),
        child:
            titleWidget ??
            Text(title ?? "common.continue".tr(), style: titleStyle ?? AppTextStyles.textHeader3.copyWith(color: AppColors.white)),
      ),
    );
  }
}
