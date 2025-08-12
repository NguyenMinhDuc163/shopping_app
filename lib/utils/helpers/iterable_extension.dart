// https://github.com/dart-lang/collection/blob/master/lib/src/iterable_extensions.dart
// ignore_for_file: use_function_type_syntax_for_parameters

extension IterableExt<E> on Iterable<E> {
  /// The first element satisfying [test], or `null` if there are none.
  E? firstWhereOrNull(bool test(E element)) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Returns the [index]th element, or `null` if there is no such element.
  ///
  /// The [index] must be non-negative and less than [length].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// final elementAt = numbers.elementAtOrNull(4); // 6
  /// ```
  E? elementAtOrNull(int index) {
    RangeError.checkNotNegative(index, "index");
    int elementIndex = 0;
    for (E element in this) {
      if (index == elementIndex) return element;
      elementIndex++;
    }
    return null;
  }
}
