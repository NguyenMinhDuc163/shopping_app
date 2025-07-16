import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_constants.dart';

class AppTextTheme {
  static const defaultTextStyle = TextStyle(
    fontFamily: AppConst.robotoFont,
    leadingDistribution: TextLeadingDistribution.even,
  );
  static final AppBaseText base = AppBaseText(defaultTextStyle, {
    12: 22,
    13: 23,
    14: 24,
  });
}

class AppBaseText extends TextStyle {
  final TextStyle s12;
  final TextStyle s13;
  final TextStyle s14;
  AppBaseText(TextStyle baseText, Map<int, double> lightHeights)
    : s12 = baseText.copyWith(fontSize: 12, height: lightHeights[12]! / 12),
      s13 = baseText.copyWith(fontSize: 13, height: lightHeights[13]! / 13),
      s14 = baseText.copyWith(fontSize: 14, height: lightHeights[14]! / 14),
      super(fontFamily: baseText.fontFamily);
}
