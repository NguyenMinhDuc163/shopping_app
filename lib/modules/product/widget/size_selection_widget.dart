import '../../../init.dart';

class SizeSelectionWidget extends StatefulWidget {
  final Function(int)? onSizeChanged;
  final List<String>? sizes;
  final List<String>? availableSizes;
  final int? initialSelectedIndex;
  final Function(int)? isSizeAvailable;

  const SizeSelectionWidget({
    super.key,
    this.onSizeChanged,
    this.sizes,
    this.availableSizes,
    this.initialSelectedIndex,
    this.isSizeAvailable,
  });

  @override
  State<SizeSelectionWidget> createState() => _SizeSelectionWidgetState();
}

class _SizeSelectionWidgetState extends State<SizeSelectionWidget> {
  late int selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.initialSelectedIndex ?? 0;
  }

  @override
  void didUpdateWidget(SizeSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedIndex != null &&
        widget.initialSelectedIndex != selectedSize) {
      setState(() {
        selectedSize = widget.initialSelectedIndex!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.sizes?.length ?? 0, (index) {
          final isSelected = selectedSize == index;
          final isAvailable = widget.isSizeAvailable?.call(index) ?? true;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap:
                  isAvailable
                      ? () {
                        setState(() {
                          selectedSize = index;
                        });
                        widget.onSizeChanged?.call(index);
                      }
                      : null,
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isAvailable
                          ? AppColors.lightGray
                          : AppColors.lightGray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isSelected
                            ? AppColors.lavenderColor
                            : AppColors.lightGray,
                    width: 2,
                  ),
                ),
                child: Text(
                  widget.sizes?[index] ?? '',
                  style: TextStyle(
                    color: isAvailable ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
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
