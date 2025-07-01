import 'dart:math';

extension DoubleExtension on double {
  /// Returns this [num] clamped to not exceed [upperLimit].
  /// In other words, return the lesser of two numbers,
  /// this [num] and [upperLimit].
  ///
  /// The lesser of `-0.0` and `0.0` is `-0.0`.
  double clampMaxTo(double max) => min(this, max);
}
