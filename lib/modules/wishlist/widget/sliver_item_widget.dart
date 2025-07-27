import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import '../../../init.dart';

class SliverItemWidget extends StatelessWidget {
  const SliverItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppPad.h24v10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${MockData.products.length} ${'wishlist.items'.tr()}',
                  style: AppTextStyles.textHeader3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "wishlist.in_wishlist".tr(),
                  style: AppTextStyles.textContent3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            ButtonWidget(
              titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(IconPath.iconEdit, width: 16, height: 16),
                  SizedBox(width: 4),
                  Text(
                    'wishlist.edit'.tr(),
                    style: AppTextStyles.textContent2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.lightGray,
              boderRadius: AppBorderRadius.a8,
              padding: AppPad.h8v4,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
