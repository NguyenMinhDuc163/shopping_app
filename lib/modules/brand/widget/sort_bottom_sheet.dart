import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/values/order_by.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';

class SortBottomSheet extends StatefulWidget {
  final Function(SortType)? onSortChanged;
  final SortType? currentSort;

  const SortBottomSheet({super.key, this.onSortChanged, this.currentSort});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  SortType? selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Text(
              'brand_screen.sort'.tr(),
              style: AppTextStyles.textHeader3.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),


          Padding(
            padding: AppPad.h24,
            child: Column(
              children: [
                _buildSortOption(
                  'brand_screen.price_low_to_high'.tr(),
                  SortType.priceAsc,
                  selectedSort == SortType.priceAsc,
                ),
                const SizedBox(height: 12),
                _buildSortOption(
                  'brand_screen.price_high_to_low'.tr(),
                  SortType.priceDesc,
                  selectedSort == SortType.priceDesc,
                ),
                const SizedBox(height: 12),
                _buildSortOption(
                  'brand_screen.by_product_name_asc'.tr(),
                  SortType.nameAsc,
                  selectedSort == SortType.nameAsc,
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    title: 'brand_screen.cancel'.tr(),
                    backgroundColor: AppColors.lightGray,
                    titleStyle: AppTextStyles.textContent2.copyWith(
                      color: AppColors.coolGray,
                      fontWeight: FontWeight.w500
                    ),
                    boderRadius: AppBorderRadius.a10,
                    padding: AppPad.v12,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ButtonWidget(
                    title: 'brand_screen.confirm'.tr(),
                    backgroundColor: AppColors.lavenderColor,
                    titleStyle: AppTextStyles.textContent2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    boderRadius: AppBorderRadius.a10,
                    padding: AppPad.v12,
                    onPressed: () {
                      if (widget.onSortChanged != null) {
                        widget.onSortChanged!(selectedSort!);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String title, SortType value, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSort = value;
        });
      },
      child: Container(
        padding: AppPad.h16v12,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: AppBorderRadius.a10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.textContent2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
          ],
        ),
      ),
    );
  }
}
