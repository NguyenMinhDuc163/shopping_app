import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/home/widget/new_arrival_widget.dart';
import 'package:shopping_app/modules/wishlist/widget/sliver_item_widget.dart';

import '../../../init.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  static const String routeName = '/wishlistScreen';
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final Set<int> favoriteIndexes = {};
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowDrawer: true,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
      titleWidget: Text('common.wishlist'.tr(), style: AppTextStyles.textHeader3,),
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
          slivers: [
            SliverItemWidget(),
            NewArrivalWidget()
          ],
        ),
      ),
    );
  }
}
