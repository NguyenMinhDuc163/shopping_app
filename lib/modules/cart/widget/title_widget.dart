import 'package:easy_localization/easy_localization.dart';

import '../../../init.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.textHeader3),
        InkWell(
            onTap: onTap,
            child: Icon(Icons.chevron_right, color: Colors.black)),
      ],
    );
  }
}
