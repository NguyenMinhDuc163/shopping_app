import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(double, double)? onPriceRangeChanged;
  final double? minPrice;
  final double? maxPrice;

  const FilterBottomSheet({
    super.key,
    this.onPriceRangeChanged,
    this.minPrice,
    this.maxPrice,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  bool _hasPriceRange = false;

  @override
  void initState() {
    super.initState();

    if (widget.minPrice != null) {
      _minPriceController.text = widget.minPrice!.toString();
      _hasPriceRange = true;
    }
    if (widget.maxPrice != null) {
      _maxPriceController.text = widget.maxPrice!.toString();
      _hasPriceRange = true;
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _resetPriceRange() {
    setState(() {
      _minPriceController.clear();
      _maxPriceController.clear();
      _hasPriceRange = false;
    });
  }

  void _updatePriceRange() {
    final minPrice = double.tryParse(_minPriceController.text) ?? 0.0;
    final maxPrice = double.tryParse(_maxPriceController.text) ?? 0.0;

    if (minPrice > 0 || maxPrice > 0) {
      setState(() {
        _hasPriceRange = true;
      });

      if (widget.onPriceRangeChanged != null) {
        widget.onPriceRangeChanged!(minPrice, maxPrice);
      }
    }
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'brand_screen.filter'.tr(),
                    style: AppTextStyles.textHeader3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ButtonWidget(
                  title: 'brand_screen.reset'.tr(),
                  backgroundColor: AppColors.color00FFEA,
                  titleStyle: AppTextStyles.textContent2.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  boderRadius: AppBorderRadius.a10,
                  padding: AppPad.h12v8,
                  onPressed: _resetPriceRange,
                ),
              ],
            ),
          ),

          Padding(
            padding: AppPad.h24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'brand_screen.price_range'.tr(),
                  style: AppTextStyles.textContent1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '\$',
                          filled: true,
                          fillColor: AppColors.lightGray,
                          border: OutlineInputBorder(
                            borderRadius: AppBorderRadius.a8,
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) => _updatePriceRange(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '\$',
                          filled: true,
                          fillColor: AppColors.lightGray,
                          border: OutlineInputBorder(
                            borderRadius: AppBorderRadius.a8,
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) => _updatePriceRange(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        '${'brand_screen.from'.tr()} ${_minPriceController.text.isEmpty ? '-' : '\$${_minPriceController.text}'} ${'brand_screen.to'.tr()} ${_maxPriceController.text.isEmpty ? '-' : '\$${_maxPriceController.text}'}',
                        style: AppTextStyles.textContent3.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      if (_hasPriceRange)
                        GestureDetector(
                          onTap: _resetPriceRange,
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ),
                    ],
                  ),
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
                      fontWeight: FontWeight.w500,
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
                      if (widget.onPriceRangeChanged != null) {
                        final minPrice =
                            double.tryParse(_minPriceController.text) ?? 0.0;
                        final maxPrice =
                            double.tryParse(_maxPriceController.text) ?? 0.0;
                        widget.onPriceRangeChanged!(minPrice, maxPrice);
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
}
