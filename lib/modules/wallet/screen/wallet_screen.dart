import 'package:flutter_svg/flutter_svg.dart';

import '../../../init.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowDrawer: true,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
    );
  }
}
