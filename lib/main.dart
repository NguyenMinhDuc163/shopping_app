import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:shopping_app/utils/helpers/local_storage_helper.dart';

import 'modules/app.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();

  runApp(const App());
}
