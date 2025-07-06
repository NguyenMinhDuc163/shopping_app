import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static const TextStyle appbarTitle = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // Button

  static const TextStyle button = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle smallButton = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textButton = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Input / Form

  static const TextStyle inputTitle = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.formTitle,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle inputFieldLabel = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.formFieldLabel,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle inputHintText = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.hintText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle inputError = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.error,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  // Text

  static const TextStyle text = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.text,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textMedium = TextStyle(
    fontFamily: AppConst.robotoFont,
    color: AppColors.text,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );


  static const TextStyle cupertinoActionSheetAction = TextStyle(
    fontFamily: AppConst.robotoFont,
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle tabBarLabel = TextStyle(
    fontFamily: AppConst.robotoFont,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bottomSheetTitle = TextStyle(
    fontFamily: AppConst.robotoFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textStyleDefaultBold = TextStyle(
    fontSize: 16,
    fontFamily: AppConst.robotoFont,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const  TextStyle textStyleDefault = TextStyle(
    fontSize: 14,
    fontFamily: AppConst.robotoFont,
    color: AppColors.text,
    height: 1.40,
  );


  static TextStyle textHeader1 = textStyleDefaultBold.copyWith(fontSize: 28);

  static TextStyle textHeader2 = textStyleDefaultBold.copyWith(fontSize: 25);

  static TextStyle textHeader3 = textStyleDefaultBold.copyWith(fontSize: 20);

  static TextStyle textContent1 = textStyleDefault.copyWith(fontSize: 17);

  static TextStyle textContent2 = textStyleDefault.copyWith(fontSize: 15);

  static TextStyle textContent3 = textStyleDefault.copyWith(fontSize: 13);

  static TextStyle textContent4 = textStyleDefault.copyWith(fontSize: 11);


  static const TextStyle introDescription = text;
}
