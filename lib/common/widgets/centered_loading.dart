import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopping_app/utils/ui/lerp.dart';

class CenteredLoading extends StatelessWidget {
  const CenteredLoading({
    super.key,
    this.width = double.infinity,
    this.height,
  });

  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final CenteredLoadingTheme? theme = Theme.of(context).extension<CenteredLoadingTheme>();

    Widget child;
    if (theme == null) {
      child = const Center(child: CircularProgressIndicator());
    } else {
      child = CircularProgressIndicator(
        color: theme.color,
        strokeWidth: theme.strokeWidth,
        strokeCap: theme.strokeCap,
      );

      if (theme.dimension != _kIndicatorSize) {
        child = SizedBox.square(
          dimension: theme.dimension,
          child: child,
        );
      }

      child = Center(child: child);
    }

    if (height == null) return child;

    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}

class SliverCenteredLoading extends StatelessWidget {
  const SliverCenteredLoading({
    super.key,
    this.width = double.infinity,
    this.height,
    this.hasScrollBody = false,
  });

  final double width;
  final double? height;
  final bool hasScrollBody;

  @override
  Widget build(BuildContext context) {
    final CenteredLoadingTheme? theme = Theme.of(context).extension<CenteredLoadingTheme>();

    Widget child;
    if (theme == null) {
      const defaultChild = Center(child: CircularProgressIndicator());

      if (width == double.infinity && height == null) {
        if (!hasScrollBody) {
          return const SliverToBoxAdapter(child: defaultChild);
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: defaultChild,
        );
      }

      child = defaultChild;
    } else {
      child = CircularProgressIndicator(
        color: theme.color,
        strokeWidth: theme.strokeWidth,
        strokeCap: theme.strokeCap,
      );

      if (theme.dimension != _kIndicatorSize) {
        child = SizedBox.square(
          dimension: theme.dimension,
          child: child,
        );
      }

      child = Center(child: child);

      if (width == double.infinity && height == null) {
        if (!hasScrollBody) {
          return SliverToBoxAdapter(child: child);
        }

        return SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        );
      }
    }

    final result = SizedBox(
      width: width,
      height: height,
      child: child,
    );

    if (!hasScrollBody) {
      return SliverToBoxAdapter(
        child: result,
      );
    }

    return SliverFillRemaining(
      hasScrollBody: false,
      child: result,
    );
  }
}

const double _kIndicatorSize = 36.0;

class CenteredLoadingTheme extends ThemeExtension<CenteredLoadingTheme> {
  CenteredLoadingTheme({
    required this.color,
    required this.strokeWidth,
    required this.strokeCap,
    this.dimension = _kIndicatorSize,
  });

  /// The progress indicator's color.
  ///
  /// If [ProgressIndicator.color] is null, then the ambient
  /// [ProgressIndicatorThemeData.color] will be used. If that
  /// is null then the current theme's [ColorScheme.primary] will
  /// be used by default.
  final Color color;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The progress indicator's line ending.
  ///
  /// This determines the shape of the stroke ends of the progress indicator.
  /// By default, [strokeCap] is null.
  /// When [value] is null (indeterminate), the stroke ends are set to
  /// [StrokeCap.square]. When [value] is not null, the stroke
  /// ends are set to [StrokeCap.butt].
  ///
  /// Setting [strokeCap] to [StrokeCap.round] will result in a rounded end.
  /// Setting [strokeCap] to [StrokeCap.butt] with [value] == null will result
  /// in a slightly different indeterminate animation; the indicator completely
  /// disappears and reappears on its minimum value.
  /// Setting [strokeCap] to [StrokeCap.square] with [value] != null will
  /// result in a different display of [value]. The indicator will start
  /// drawing from slightly less than the start, and end slightly after
  /// the end. This will produce an alternative result, as the
  /// default behavior, for example, that a [value] of 0.5 starts at 90 degrees
  /// and ends at 270 degrees. With [StrokeCap.square], it could start 85
  /// degrees and end at 275 degrees.
  final StrokeCap strokeCap;

  /// The size of indicator.
  final double dimension;

  @override
  ThemeExtension<CenteredLoadingTheme> copyWith({
    Color? color,
    double? strokeWidth,
    StrokeCap? strokeCap,
    double? dimension,
  }) {
    return CenteredLoadingTheme(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeCap: strokeCap ?? this.strokeCap,
      dimension: dimension ?? this.dimension,
    );
  }

  @override
  ThemeExtension<CenteredLoadingTheme> lerp(CenteredLoadingTheme? other, double t) {
    return CenteredLoadingTheme(
      color: Color.lerp(color, other?.color, t)!,
      strokeWidth: lerpDouble(strokeWidth, other?.strokeWidth, t)!,
      strokeCap: lerpProperty(strokeCap, other?.strokeCap, t)!,
      dimension: lerpDouble(dimension, other?.dimension, t)!,
    );
  }
}
