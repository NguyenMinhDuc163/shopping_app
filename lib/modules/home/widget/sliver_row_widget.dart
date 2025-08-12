import 'package:shopping_app/core/widgets/sliver_pad_to_box.dart';

import '../../../init.dart';

class SliverRowWidget extends StatelessWidget {
  const SliverRowWidget({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SliverPadToBox(
      padding: AppPad.a16, // tinh lai padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.textContent1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(child: Text(value, style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}
