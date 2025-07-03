import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';


class SwitchLang extends StatelessWidget {
  const SwitchLang({
    super.key,
    required this.onTap,
    this.switchLang = true,
    this.colorText,
    this.colorBackground,
  });

  final VoidCallback onTap;
  final bool switchLang;
  final Color? colorText;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 15,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: colorBackground ?? Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (switchLang)
                  Container(
                    color: Colors.red,
                    width: 10,
                    height: 10,
                  )
                else
                  Text(
                    "VN ",
                    style: AppTextStyles.text,
                  ),
                if (switchLang)
                  Text(
                    " EN",
                    style: AppTextStyles.text,
                  )
                else
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        color: Colors.red,
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                SizedBox(width: 4,),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Center(
                    child: Container(
                      color: Colors.red,
                      width: 10,
                      height: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
