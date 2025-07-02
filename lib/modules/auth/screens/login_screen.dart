import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      title: "Login Screen",
    );
  }
}