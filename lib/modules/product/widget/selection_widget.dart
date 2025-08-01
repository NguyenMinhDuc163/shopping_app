import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';

class SelectionWidget<T> extends StatefulWidget {
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
  State<SelectionWidget<T>> createState() => _SelectionWidgetState<T>();
}

class _SelectionWidgetState<T> extends State<SelectionWidget<T>> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  void didUpdateWidget(SelectionWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedIndex != selectedIndex) {
      setState(() {
        selectedIndex = widget.initialSelectedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          final isSelected = selectedIndex == index;
          final isAvailable = widget.isItemAvailable(index);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: isAvailable ? () {
                setState(() {
                          selectedIndex = index;
                        });
                        widget.onSelectionChanged(index);
                      }
                      : null,
              child: Container(
                width:  isSelected ? 58 : 60,
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
                child: widget.itemBuilder(item, isSelected, isAvailable),
              ),
            ),
          );
        }),
      ),
    );
  }
}
