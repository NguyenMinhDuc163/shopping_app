import 'package:flutter_svg/flutter_svg.dart';

import '../../../init.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowDrawer: true,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
    );
  }
}
