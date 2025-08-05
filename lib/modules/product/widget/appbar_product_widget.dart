import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';

import '../../../init.dart';

class AppbarProductWidget extends StatelessWidget {
  const AppbarProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPad.h16,
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
                onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
