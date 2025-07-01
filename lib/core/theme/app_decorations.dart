import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppDecorations {
  static const thumbnailDecocation = BoxDecoration(
    color: AppColors.white,
    boxShadow: thumbnailShadow,
  );

  static const thumbnailShadow = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      color: Color.fromRGBO(0, 0, 0, 0.075),
    ),
  ];
}