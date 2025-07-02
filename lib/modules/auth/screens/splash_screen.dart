import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirectIntroScreen();
  }

  void redirectIntroScreen() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: AppColors.gray)),
        // Center(
        //   child: ImageHelper.loadFromAsset(
        //     AssetHelper.icoLogo,
        //     width: 250,
        //     height: 250,
        //     alignment: Alignment.center,
        //   ),
        // ),
        Center(child: Container(color: Colors.red, width: 250, height: 250)),
      ],
    );
  }
}
