import '../../../init.dart';

class RowHeaderWidget extends StatelessWidget {
  const RowHeaderWidget({super.key, this.value = "", this.title = "", this.onTap});
  final String title;
  final String value;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return                   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.textContent1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => onTap?.call(),
          child: Text(
            value,
            style: AppTextStyles.textContent3.copyWith(
              color: AppColors.coolGray,
            ),
          ),
        ),
      ],
    );
  }
}
