import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/modules/product/widget/product_item_widget.dart';

import '../../../init.dart';

class NewArrivalWidget extends StatefulWidget {
  const NewArrivalWidget({super.key});

  @override
  State<NewArrivalWidget> createState() => _NewArrivalWidgetState();
}

class _NewArrivalWidgetState extends State<NewArrivalWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: (MockData.products.length * 3 / 2).ceil(),
        (context, rowIndex) {
          final int totalItems = MockData.products.length;
          final int itemsPerRow = 2;
          final int totalRows = (totalItems / itemsPerRow).ceil();

          if (rowIndex >= totalRows) return null;

          final int startIndex = rowIndex * itemsPerRow;
          final int endIndex = (startIndex + itemsPerRow).clamp(0, totalItems);
          final List<Widget> rowItems = [];

          for (int i = startIndex; i < endIndex; i++) {
            final product = MockData.products[i];
            rowItems.add(ProductItemWidget(product: product, productId: i));
          }

          while (rowItems.length < itemsPerRow) {
            rowItems.add(Flexible(child: SizedBox()));
          }

          return Padding(
            padding: AppPad.a12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rowItems,
            ),
          );
        },
      ),
    );
  }
}
