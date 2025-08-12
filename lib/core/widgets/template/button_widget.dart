import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.title,
    this.titleStyle,
    this.titleWidget,
    this.onPressed,
    this.backgroundColor = AppColors.lavenderColor,
    this.boderRadius = BorderRadius.zero,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.borderColor,
  });
  final String? title;
  final TextStyle? titleStyle;
  final Widget? titleWidget;
  final Color backgroundColor;
  final BorderRadiusGeometry boderRadius;
  final Function? onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        padding: padding,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: boderRadius,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child:
            titleWidget ??
            Text(
              title ?? "common.continue".tr(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style:
                  titleStyle ??
                  AppTextStyles.textContent1.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
      ),
    );
  }
}
