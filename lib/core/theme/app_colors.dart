import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color electricBlue = Color(0xFF04589C);

  static const Color deepBlue = Color(0xFF4267B2);

  static const Color skyBlue = Color(0xFF1DA1F2);

  static const Color crimson = Color(0xFFEA4335);

  static const Color coolGray = Color(0xFF8F959E);

  static const Color orange = Color(0xFFFD7E14);

  static const Color rustyRed = Color(0xFFDC3545);

  static const Color gray = Color(0xFF808080);

  static const Color auroMetalAaurus = Color(0xFF6C757d);

  static const Color silverGray = Color(0xFFE7E8EA);

  static const Color raisinBlack = Color(0xFF202020);

  static const Color darkShadeOfGray = Color.fromRGBO(17, 17, 17, 0.5);

  /// Colors.black.withOpacity(0.5)
  static const Color black50 = Color(0x80000000);

  static const Color white = Color(0xFFFFFFFF);

  //

  static const Color brand = electricBlue;

  static const Color primary = electricBlue; // Dark Gunmetal 34281C

  // static const Color secondary = ;

  static const Color highlight = orange;

  static const Color error = rustyRed;

  static const Color active = primary;

  // static const Color inactive = ;

  static const Color success = Color(0xFF28A745);

  //

  static const Color background = Color(0xFFFAFAFA);

  static const Color bodyBackground = white;

  static const Color border = gray;

  //

  static const Color divider = auroMetalAaurus;

  //

  static const Color sectionTitle = primary;

  static const Color text = raisinBlack;

  static const Color description = raisinBlack;

  //

  static const Color icon = raisinBlack;

  //

  static const Color barrier = darkShadeOfGray;

  static const Color dialogBarrier = darkShadeOfGray;

  static const Color mbsBarrier = darkShadeOfGray;

  //

  static const Color shadowBlack15 = Color.fromRGBO(0, 0, 0, 0.15);

  static const Color formShadow = Color.fromRGBO(76, 91, 212, 0.15);

  // Form

  static const Color formTitle = primary;

  static const Color formFieldLabel = raisinBlack;

  static const Color formRequired = rustyRed;

  static const Color hintText = auroMetalAaurus;

  // Shimmer

  static const Color shimmerBaseColor = Color(0xFFF1F2F3);

  static const Color shimmerHighlightColor = Color(0xFFE3E6E8);
  static const Color lavenderColor = Color(0xFF9775FA);
  static const Color colorF6F2FF = Color(0xFFF6F2FF);
  static const Color lightGray = Color(0xFFF5F6FA);
  static const Color limeGreen = Color(0xFF34C358);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color colorFEFEFE = Color(0xFFFEFEFE);
  static const Color colorDEDEDE = Color(0xFFDEDEDE);
  static const Color colorFF7043 = Color(0xFFFF7043);
  static const Color colorC64B4D = Color(0xFFC64B4D);
  static const Color colorD9E3DC = Color(0xFFD9E3DC);
  static const Color color00FFEA = Color(0xFF00FFEA);

  // gradient
  static const LinearGradient gradientPrimaryColor = LinearGradient(
    colors: [
      shimmerHighlightColor,
      lavenderColor,
      lavenderColor,
      shimmerHighlightColor,
    ],
    stops: [0.0, 0.15, 0.85, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
