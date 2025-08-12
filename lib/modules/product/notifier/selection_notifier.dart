import 'package:flutter/foundation.dart';

class SelectionNotifier extends ValueNotifier<int> {
  SelectionNotifier({int initialSelectedIndex = 0}) : super(initialSelectedIndex);

  void selectIndex(int index) {
    if (value != index) {
      value = index;
    }
  }
}
