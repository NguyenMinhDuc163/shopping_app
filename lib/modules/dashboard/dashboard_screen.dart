import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/home/home_screen.dart';
import 'package:shopping_app/modules/wallet/screen/wallet_screen.dart';
import 'package:shopping_app/modules/wishlist/screen/wishlist_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const String routeName = '/dashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            WishlistScreen(),
            CartScreen(),
            WalletScreen(),
          ],
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
    );
  }
}
