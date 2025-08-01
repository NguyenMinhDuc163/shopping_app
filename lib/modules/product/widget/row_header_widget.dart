import 'package:flutter_svg/flutter_svg.dart';

import '../../../init.dart';

class RowHeaderWidget extends StatelessWidget {
  const RowHeaderWidget({
    super.key,
    this.value = "",
    this.title = "",
    this.onTap,
    this.valueStyle,
    this.isShowIcon = false,
  });
  final String title;
  final String value;
  final TextStyle? valueStyle;
  final bool isShowIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.textContent1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (value.isNotEmpty)
          GestureDetector(
            onTap: () => onTap?.call(),
            child: Row(
              spacing: 5,
              children: [
                Visibility(
                  visible: isShowIcon,
                  child: SvgPicture.asset(
                    IconPath.iconWarring,
                    color: valueStyle?.color ?? AppColors.coolGray,
                    width: 15,
                    height: 15,
                  ),
                ),
                Text(
                  value,
                  style:
                      valueStyle ??
                      AppTextStyles.textContent3.copyWith(
                        color: AppColors.coolGray,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
