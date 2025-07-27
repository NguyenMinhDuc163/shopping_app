import '../../../init.dart';

class SizeSelectionWidget extends StatefulWidget {
  const SizeSelectionWidget({super.key});

  @override
  State<SizeSelectionWidget> createState() => _SizeSelectionWidgetState();
}

class _SizeSelectionWidgetState extends State<SizeSelectionWidget> {
  int selectedSize = 1;
  final List<String> sizes = ['S', 'M', 'L', 'XL', '2XL'];
  final List<String> availableSizes = ['S', 'XL', '2XL'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(sizes.length, (index) {
          final isSelected = selectedSize == index;
          final isAvailable = availableSizes.contains(sizes[index]);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap:
                  isAvailable
                      ? () {
                        setState(() {
                          selectedSize = index;
                        });
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
                  sizes[index],
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
