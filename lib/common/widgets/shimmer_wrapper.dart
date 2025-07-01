import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      period: const Duration(milliseconds: 900),
      child: child,
    );
  }
}
