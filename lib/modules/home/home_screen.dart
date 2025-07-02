import 'package:flutter/material.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';

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
      title: "Home Screen",
      isShowBottomButton: false,
    );
  }
}
