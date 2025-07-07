import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/public/navigation_service.dart';

import '../../../init.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarWidget({
    super.key,
    this.backgroundColor,
    this.leadingWidget,
    this.isShowDrawer,
    this.onBack,
    this.titleWidget,
    this.title,
    this.actionsWidget,
  });
  final Color? backgroundColor;
  final Widget? leadingWidget, titleWidget;
  final bool? isShowDrawer;
  final Function? onBack;
  final String? title;
  final List<Widget>? actionsWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: 0,
      leading: Padding(
        padding: AppPad.a8,
        child: CircleAvatar(
          backgroundColor: AppColors.lightGray,
          child:
              leadingWidget ??
              (isShowDrawer ?? false
                  ? Builder(
                    builder:
                        (context) => IconButton(
                          icon: SvgPicture.asset(IconPath.iconMenu),
                          onPressed: () {
                            NavigationService.scaffoldKey.currentState?.openDrawer();
                            // Scaffold.of(context).openDrawer();
                          },
                        ),
                  )
                  : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (onBack != null) {
                        onBack!();
                      } else {
                        Navigator.of(context).maybePop();
                      }
                    },
                  )),
        ),
      ),
      title:
          titleWidget ??
          (title != null
              ? Text(title!, style: AppTextStyles.textContent1)
              : null),
      centerTitle: true,
      actions:
          actionsWidget
              ?.map(
                (e) => Padding(
                  padding: AppPad.a8,
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightGray,
                    child: e,
                  ),
                ),
              )
              .toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
