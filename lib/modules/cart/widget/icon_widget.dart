import '../../../init.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key, required this.iconPath});
  final IconData iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.colorDEDEDE, width: 1.5),
        color: Colors.white,
      ),
      child: Icon(iconPath, size: 15, color: AppColors.coolGray),
    );;
  }
}
