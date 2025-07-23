import 'package:shopping_app/core/widgets/sliver_pad_to_box.dart';

import '../../../init.dart';

class SliverHeaderWidget extends StatelessWidget {
  const SliverHeaderWidget({super.key, });

  @override
  Widget build(BuildContext context) {
    return  SliverPadToBox(
      padding: AppPad.h22v15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
             "Nguyen Duc",
            style: AppTextStyles.textHeader2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Welcome to Laza.',
            style: AppTextStyles.textContent3.copyWith(
              color: AppColors.coolGray,
            ),
          ),
        ],
      ),
    );
  }
}
