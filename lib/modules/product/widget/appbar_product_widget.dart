import 'package:flutter_svg/flutter_svg.dart';

import '../../../init.dart';

class AppbarProductWidget extends StatelessWidget {
  const AppbarProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPad.h16v40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: IconButton(
              icon: SvgPicture.asset(IconPath.iconBag),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
