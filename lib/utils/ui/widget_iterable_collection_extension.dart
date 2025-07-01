extension WidgetIterableCollectionExtension<Widget> on Iterable<Widget> {
  Iterable<Widget> separateWith([Widget? widget]) sync* {
    if (widget == null) {
      yield* this;
      return;
    }

    final int len = length;

    if (len == 1) {
      yield* this;
      return;
    }

    int count = 0;
    final Iterator<Widget> it = iterator;
    while (it.moveNext()) {
      count++;
      yield it.current;
      if (count != len) yield widget;
    }
  }

  Iterable<Widget> separateWithGroup([Iterable<Widget>? widgets]) sync* {
    if (widgets == null) {
      yield* this;
      return;
    }

    final int len = length;

    if (len == 1) {
      yield* this;
      return;
    }

    int count = 0;
    final Iterator<Widget> it = iterator;
    while (it.moveNext()) {
      count++;
      yield it.current;
      if (count != len) yield* widgets;
    }
  }

  /// Return a new [Iterable] with [widget] added to the beginning
  /// of the current iterable.
  ///
  /// ```dart
  /// List<Widget> arr = [ D(), E(), F() ];
  ///
  /// print(
  ///   arr.unshift( widget: A() )
  /// ); // [ A(), D(), E(), F() ]
  /// ```
  Iterable<Widget> unshift([Widget? widget]) sync* {
    if (widget != null) yield widget;

    yield* this;
  }

  /// Return a new [Iterable] with all [widgets] added to the beginning
  /// of the current iterable.
  ///
  /// ```dart
  /// List<Widget> arr = [ D(), E(), F() ];
  ///
  /// print(
  ///   arr.unshift(widgets: [ A(), B(), C() ])
  /// ); // [ A(), B(), C(), D(), E(), F() ]
  /// ```
  Iterable<Widget> unshiftAll([Iterable<Widget>? widgets = const []]) sync* {
    if (widgets != null && widgets.isNotEmpty) yield* widgets;

    yield* this;
  }

  /// Return a new [Iterable] with [widget] added to the end
  /// of the current iterable.
  ///
  /// ```dart
  /// List<Widget> arr = [ D(), E(), F() ];
  ///
  /// print(
  ///   arr.push( widget: A() )
  /// ); // [ D(), E(), F(), A() ]
  /// ```
  Iterable<Widget> push([Widget? widget]) sync* {
    yield* this;

    if (widget != null) yield widget;
  }

  /// Return a new [Iterable] with all [widgets] added to the end
  /// of the current iterable.
  ///
  /// ```dart
  /// List<Widget> arr = [ D(), E(), F() ];
  ///
  /// print(
  ///   arr.unshift(widgets: [ A(), B(), C() ])
  /// ); // [ D(), E(), F(), A(), B(), C() ]
  /// ```
  Iterable<Widget> pushAll([Iterable<Widget>? widgets = const []]) sync* {
    yield* this;

    if (widgets != null && widgets.isNotEmpty) yield* widgets;
  }
}

extension IterableOfWidgetIterableCollectionExtension<Widget> on Iterable<Iterable<Widget>> {
  Iterable<Widget> flatAndSeparateWith([Widget? widget]) sync* {
    if (widget == null) {
      yield* expand((e) => e);
      return;
    }

    final int len = length;

    if (len == 1) {
      yield* expand((e) => e);
      return;
    }

    int count = 0;
    final Iterator<Iterable<Widget>> it = iterator;
    while (it.moveNext()) {
      count++;
      yield* it.current;
      if (count != len) yield widget;
    }
  }

  Iterable<Widget> flatAndSeparateWithGroup([Iterable<Widget>? widgets]) sync* {
    if (widgets == null) {
      yield* expand((e) => e);
      return;
    }

    final int len = length;

    if (len == 1) {
      yield* expand((e) => e);
      return;
    }

    int count = 0;
    final Iterator<Iterable<Widget>> it = iterator;
    while (it.moveNext()) {
      count++;
      yield* it.current;
      if (count != len) yield* widgets;
    }
  }
}
