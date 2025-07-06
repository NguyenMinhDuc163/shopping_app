import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class TextSpanWidget extends StatelessWidget {
  const TextSpanWidget({
    super.key,
    required this.normalText,
    required this.clickableText,
    required this.onTap,
    this.padding,
    this.normalTextStyle,
    this.clickableTextStyle,
  });

  final String normalText;
  final String clickableText;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? normalTextStyle;
  final TextStyle? clickableTextStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppPad.h20v10,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: normalText,
              style:
                  normalTextStyle ??
                  AppTextStyles.textContent2.copyWith(
                    color: AppColors.coolGray,
                  ),
            ),
            TextSpan(
              text: clickableText,
              style:
                  clickableTextStyle ??
                  AppTextStyles.textContent2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
