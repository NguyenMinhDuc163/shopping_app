import 'dart:async';

import 'package:flutter/widgets.dart';

typedef ActionCallback = void Function(BuildContext context);

typedef ViewListenerStateCallback = void Function(BuildContext context);

/// Signature for callbacks that report that a value has been set and return either
/// a `Future<T>` or `T` that completes when the value has been saved.
typedef AsyncOrValueSetter<T> = FutureOr<void> Function(T value);

/// Signature for callbacks that are to (asynchronously) report a value on demand.
typedef AsyncOrValueGetter<T> = FutureOr<T> Function();

typedef ImagePrecacher = Future<void> Function(String url);

typedef ErrorableImagePrecacher = Future<void> Function(String url, VoidCallback onLoadFailed);

typedef ErrorMessageCallback = void Function(String message);
