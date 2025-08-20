import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/widgets/switch_botton_widget.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/auth/login/screen/login_screen.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/sign_in_repo.dart';
import 'package:shopping_app/modules/auth/sign_in/screen/sign_in_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: AppPad.v40,
          children: <Widget>[
            Padding(
              padding: AppPad.h20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: AppColors.offWhite,
                    child: SvgPicture.asset(IconPath.iconMenu),
                  ),
                ),
              ),
            ),

            Container(
              padding: AppPad.a20,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: _buildDrawerHeader(),
            ),
            Row(
              children: [
                Expanded(
                  child: _buildDrawerItem(
                    icon: IconPath.iconSun,
                    title: 'common.dark_mode'.tr(),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Padding(padding: AppPad.h10, child: SwitchBottomWidget(onChanged: (value) {})),
              ],
            ),
            _buildDrawerItem(
              icon: IconPath.iconWarring,
              title: 'common.account_information'.tr(),
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: IconPath.iconLock,
              title: 'common.change_password'.tr(),
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: IconPath.iconBag,
              title: 'common.order'.tr(),
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: IconPath.iconWallet,
              title: 'common.my_cards'.tr(),
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: IconPath.iconHeart,
              title: 'common.wishlist'.tr(),
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: IconPath.iconSetting,
              title: 'common.settings'.tr(),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            _buildDrawerItem(
              icon: IconPath.iconLogout,
              title: 'common.logout'.tr(),
              iconColor: Colors.red,
              textStyle: AppTextStyles.textContent2.copyWith(color: Colors.red),
              onTap: () async {
                await context.read<SignInRepo>().authLocalDataSource.deleteToken();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: width_8,
      children: [
        CircleAvatar(radius: 25, backgroundColor: Colors.grey[200], child: Icon(Icons.person)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nguyen Duc", style: AppTextStyles.textHeader3),
            Row(
              children: [
                Text(
                  "common.verified_profile".tr(),
                  style: AppTextStyles.textContent2.copyWith(color: AppColors.coolGray),
                ),
                SvgPicture.asset(IconPath.iconDone),
              ],
            ),
          ],
        ),
        ButtonWidget(
          title: "common.orders".tr(),
          boderRadius: AppBorderRadius.a8,
          padding: AppPad.h10v8,
          backgroundColor: AppColors.offWhite,
          titleStyle: AppTextStyles.textContent3.copyWith(color: AppColors.coolGray),
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon, color: iconColor ?? Colors.grey[700]),
      title: Text(title, style: textStyle ?? AppTextStyles.textContent2),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      dense: true,
    );
  }
}
