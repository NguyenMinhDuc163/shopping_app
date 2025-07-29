import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/modules/brand/widget/sliver_brand_header_widget.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/home/widget/new_arrival_widget.dart';

import '../../../init.dart';

class BrainScreen extends StatefulWidget {
  const BrainScreen({super.key, required this.brand});
  static const String routeName = '/brainScreen';

  final Map<String, dynamic> brand;
  @override
  State<BrainScreen> createState() => _BrainScreenState();
}

class _BrainScreenState extends State<BrainScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
      titleWidget: Container(
        padding: AppPad.a8,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: AppBorderRadius.a12,
        ),
        width: 75,
        height: 45,
        child: SvgPicture.asset(widget.brand['icon']),
      ),
      screen: FunctionScreenTemplate(
        isShowBottomButton: false,
        isShowAppBar: false,
        isShowDrawer: true,
        actionsWidget: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
            child: SvgPicture.asset(IconPath.iconBag),
          ),
        ],
        screen: CustomScrollView(
          slivers: [SliverBrainHeaderWidget(), NewArrivalWidget()],
        ),
      ),
    );
    ;
  }
}
