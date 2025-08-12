import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/widgets/drawer_widget.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/dashboard/model/tab_item.dart';
import 'package:shopping_app/modules/home/screen/home_screen.dart';
import 'package:shopping_app/modules/wallet/screen/wallet_screen.dart';
import 'package:shopping_app/modules/wishlist/screen/wishlist_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const String routeName = '/dashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

final List<TabItem> _tabs = [
  TabItem(widget: HomeScreen(), route: HomeScreen.routeName),
  TabItem(widget: WishlistScreen(), route: WishlistScreen.routeName),
  TabItem(widget: CartScreen(), route: CartScreen.routeName),
  TabItem(widget: WalletScreen(), route: WalletScreen.routeName),
];

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: AppColors.white,
          systemNavigationBarContrastEnforced:false,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: DrawerWidget() ,
          body: IndexedStack(
            index: _currentIndex,
            children: _tabs.map((tab) => tab.widget).toList(),
          ),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            selectedColorOpacity: 0.0,
            backgroundColor: Colors.transparent,
            duration: Duration.zero,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              print('====>: ${_tabs[index].route}');
            },
            items: [
              SalomonBottomBarItem(
                icon: SvgPicture.asset(IconPath.iconHome),
                title: Text("home_screen.home".tr()),
                activeIcon: SizedBox.shrink(),
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(IconPath.iconWishlist),
                title: Text("home_screen.wishlist".tr()),
                activeIcon: SizedBox.shrink(),
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(IconPath.iconCart),
                title: Text("home_screen.cart".tr()),
                activeIcon: SizedBox.shrink(),
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(IconPath.iconWallet),
                title: Text("home_screen.wallet".tr()),
                activeIcon: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
