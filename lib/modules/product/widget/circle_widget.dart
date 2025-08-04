import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(painter: CirclePainter()),
        Positioned(top: 30, child: SvgPicture.asset(imagePath, width: 30, height: 30)),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.colorD9E3DC.withOpacity(.8)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 45.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi, pi, true, paint);

    final rectWidth = radius * 2;
    final rectHeight = 8.0;
    final rectLeft = center.dx - radius;
    final rectTop = center.dy;

    canvas.drawRect(Rect.fromLTWH(rectLeft, rectTop, rectWidth, rectHeight), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
