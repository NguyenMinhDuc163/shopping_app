import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class ButtonItem {
  final String title;
  final String imageUrl;
  final bool isVisible;
  final Function() onPressed;

  ButtonItem({
    required this.title,
    required this.imageUrl,
    required this.onPressed,
    this.isVisible = true,
  });
}

class ButtonWidget extends StatelessWidget {
  final List<ButtonItem> buttons;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? containerPadding;
  final double buttonHeight;
  final double iconSize;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final BoxShadow? boxShadow;

  const ButtonWidget({
    Key? key,
    required this.buttons,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(5),
    this.containerPadding,
    this.buttonHeight = 80,
    this.iconSize = 30,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow:
            boxShadow != null
                ? [boxShadow!]
                : [
                  BoxShadow(
                    color: AppColors.white.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
      ),
      padding: containerPadding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children:
            buttons
                .where((button) => button.isVisible)
                .map(
                  (button) => Expanded(
                    child: _buildButton(
                      title: button.title,
                      imageUrl: button.imageUrl,
                      onPressed: button.onPressed,
                      isVisible: button.isVisible,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required Function() onPressed,
    required String imageUrl,
    required bool isVisible,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imageUrl,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: textStyle ?? AppTextStyles.textButton,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
