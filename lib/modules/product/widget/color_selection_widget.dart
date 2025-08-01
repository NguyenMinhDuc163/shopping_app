import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

import 'package:shopping_app/modules/product/model/product_model.dart';

class ColorSelectionWidget extends StatefulWidget {
  final Function(int) onColorChanged;
  final List<ColorModel> colors;
  final List<ColorModel> availableColors;
  final int initialSelectedIndex;
  final Function(int) isColorAvailable;

  const ColorSelectionWidget({
    super.key,
   required this.onColorChanged ,
    this.colors = const [],
    this.availableColors = const [],
    this.initialSelectedIndex = 0,
    required this.isColorAvailable,
  });

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  late int selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialSelectedIndex ?? 0;
  }

  @override
  void didUpdateWidget(ColorSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedIndex != selectedColor) {
        selectedColor = widget.initialSelectedIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected;
    bool isAvailable;
    if(widget.colors.isEmpty ) return  SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 5,
        children: List.generate(widget.colors.length, (index) {
           isSelected = selectedColor == index;
           isAvailable = widget.isColorAvailable.call(index) ?? true;

          return GestureDetector(
            onTap:
                isAvailable
                    ? () {
                      setState(() {
                        selectedColor = index;
                      });
                      widget.onColorChanged.call(index);
                    }
                    : null,
            child: Container(
              width: isSelected ? 58: 60,
              height: isSelected ? 58: 60,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected
                          ? AppColors.lavenderColor
                          : AppColors.lightGray,
                  width: 2,
                ),
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 0,
                          ),
                        ]
                        : null,
              ),
              child: Container(
                margin:
                    isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color:
                      isAvailable
                          ? (widget.colors[index].color ?? Colors.grey)
                          : (widget.colors[index].color.withOpacity(0.8) ??
                              Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
