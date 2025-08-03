import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/modules/product/notifier/selection_notifier.dart';

class SelectionWidget<T> extends StatelessWidget {
  final List<T> items;
  final Function(int) onSelectionChanged;
  final int initialSelectedIndex;
  final Function(int) isItemAvailable;
  final Widget Function(T, bool, bool) itemBuilder;

  const SelectionWidget({
    super.key,
    required this.items,
    required this.onSelectionChanged,
    required this.isItemAvailable,
    required this.itemBuilder,
    this.initialSelectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final selectionNotifier = SelectionNotifier(initialSelectedIndex: initialSelectedIndex);

    if (items.isEmpty) return const SizedBox.shrink();

    return ValueListenableBuilder<int>(
      valueListenable: selectionNotifier,
      builder: (context, selectedIndex, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = selectedIndex == index;
              final isAvailable = isItemAvailable(index);

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap:
                      isAvailable
                          ? () {
                            selectionNotifier.selectIndex(index);
                            onSelectionChanged(index);
                          }
                          : null,
                  child: Container(
                    width: isSelected ? 58 : 60,
                    height: isSelected ? 58 : 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.lavenderColor : AppColors.lightGray,
                        width: 2,
                      ),
                      boxShadow:
                          isSelected
                              ? [BoxShadow(color: Colors.white, spreadRadius: 2, blurRadius: 0)]
                              : null,
                    ),
                    child: itemBuilder(item, isSelected, isAvailable),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
