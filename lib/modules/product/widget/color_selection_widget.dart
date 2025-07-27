import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ColorSelectionWidget extends StatefulWidget {
  const ColorSelectionWidget({super.key});

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  int selectedColor = 1;

  final List<Color> colors = [
    Color(0xFF6786FE),
    Color(0xFFD8D8D8),
    Color(0xFFE9D4DD),
    Color(0xFFDEDEDE),
    Color(0xFFC2E3CF),
    Color(0xFF000000),
  ];

  final List<Color> availableColors = [
    Color(0xFF6786FE),
    Color(0xFFD8D8D8),
    Color(0xFFE9D4DD),
    Color(0xFFDEDEDE),
    Color(0xFF000000),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(colors.length, (index) {
          final isSelected = selectedColor == index;
          final isAvailable = availableColors.contains(colors[index]);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap:
                  isAvailable
                      ? () {
                        setState(() {
                          selectedColor = index;
                        });
                      }
                      : null,
              child: Container(
                width: 60,
                height: 60,
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
                            ? colors[index]
                            : colors[index].withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
