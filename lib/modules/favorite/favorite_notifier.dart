import 'package:flutter/foundation.dart';

class FavoriteNotifier extends ValueNotifier<bool> {
  FavoriteNotifier({bool initialValue = false}) : super(initialValue);

  void changeColor() {
    value = !value;
  }
}
