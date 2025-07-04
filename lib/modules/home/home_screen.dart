import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';

import '../../utils/helpers/utils.dart' show Utils;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      title: "home_screen.title".tr(),
      isShowBottomButton: false,
      screen: Center(
        child: TextButton(onPressed: () async{
          await Utils.setLocale(context);
          setState(() {});
        }, child: Text("home_screen.title".tr())),
      ),
    );
  }
}
