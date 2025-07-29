import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(String)? onSortChanged;
  final String? currentSort;

  const FilterBottomSheet({super.key, this.onSortChanged, this.currentSort});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.currentSort ?? 'price_low_to_high';
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
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Text(
              'Sort'.tr(),
              style: AppTextStyles.textHeader3.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Sort options
          Padding(
            padding: AppPad.h24,
            child: Column(
              children: [
                _buildSortOption(
                  'Giá từ thấp đến cao',
                  'price_low_to_high',
                  selectedSort == 'price_low_to_high',
                ),
                const SizedBox(height: 12),
                _buildSortOption(
                  'Giá từ cao đến thấp',
                  'price_high_to_low',
                  selectedSort == 'price_high_to_low',
                ),
                const SizedBox(height: 12),
                _buildSortOption(
                  'Theo tên sản phẩm (A-Z)',
                  'name_a_to_z',
                  selectedSort == 'name_a_to_z',
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    title: 'Cancel'.tr(),
                    backgroundColor: Colors.grey[200]!,
                    titleStyle: AppTextStyles.textContent2.copyWith(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                    boderRadius: AppBorderRadius.a8,
                    padding: AppPad.v12,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ButtonWidget(
                    title: 'Confirm'.tr(),
                    backgroundColor: AppColors.primary,
                    titleStyle: AppTextStyles.textContent2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    boderRadius: AppBorderRadius.a8,
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

  Widget _buildSortOption(String title, String value, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSort = value;
        });
      },
      child: Container(
        padding: AppPad.h16v12,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: AppBorderRadius.a8,
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
