import 'package:hive_ce_flutter/adapters.dart';

class LocalStorageHelper {
  LocalStorageHelper._internal();
  static final LocalStorageHelper _shared = LocalStorageHelper._internal();
  factory LocalStorageHelper() {
    return _shared;
  }

  Box<dynamic>? hiveBox;

  static initLocalStorageHelper() async {
    _shared.hiveBox = await Hive.openBox('shopping_app');
  }

  static dynamic getValue(String key) {
    return _shared.hiveBox?.get(key);
  }

  static setValue(String key, dynamic val) {
    _shared.hiveBox?.put(key, val);
  }

  static deleteValue(String key) {
    _shared.hiveBox?.delete(key);
  }
}
