import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class OpacityWidget extends StatelessWidget {
  const OpacityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: Container(
        color: AppColors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}