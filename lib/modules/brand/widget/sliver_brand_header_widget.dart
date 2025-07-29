import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/values/order_by.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'filter_bottom_sheet.dart';
import 'sort_bottom_sheet.dart';
import '../../../init.dart';

class SliverBrainHeaderWidget extends StatefulWidget {
  const SliverBrainHeaderWidget({super.key});

  @override
  State<SliverBrainHeaderWidget> createState() =>
      _SliverBrainHeaderWidgetState();
}

class _SliverBrainHeaderWidgetState extends State<SliverBrainHeaderWidget> {
  SortType? currentSort = SortType.nameAsc;
  double? minPrice;
  double? maxPrice;

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => SortBottomSheet(
            currentSort: currentSort,
            onSortChanged: (SortType sortType) {
              setState(() {
                currentSort = sortType;
              });
            },
          ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => FilterBottomSheet(
            minPrice: minPrice,
            maxPrice: maxPrice,
            onPriceRangeChanged: (double min, double max) {
              setState(() {
                minPrice = min > 0 ? min : null;
                maxPrice = max > 0 ? max : null;
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppPad.h24v10,
        child: Row(
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
                  "wishlist.available_in_stock".tr(),
                  style: AppTextStyles.textContent3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
            ButtonWidget(
              titleWidget: SvgPicture.asset(
                IconPath.iconFilter,
                width: 20,
                height: 20,
              ),
              backgroundColor: AppColors.lightGray,
              boderRadius: AppBorderRadius.a8,
              padding: AppPad.h8v4,
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
            AppGap.w12,
            ButtonWidget(
              titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(IconPath.iconSort, width: 16, height: 16),
                  SizedBox(width: 4),
                  Text(
                    'brand_screen.sort'.tr(),
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
              onPressed: () {
                _showSortBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
