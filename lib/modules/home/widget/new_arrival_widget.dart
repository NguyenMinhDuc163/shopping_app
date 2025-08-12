import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/modules/product/widget/product_item_widget.dart';

import '../../../init.dart';
import 'package:dynamic_height_grid/dynamic_height_grid.dart';

class NewArrivalWidget extends StatefulWidget {
  const NewArrivalWidget({super.key});

  @override
  State<NewArrivalWidget> createState() => _NewArrivalWidgetState();
}

class _NewArrivalWidgetState extends State<NewArrivalWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DynamicHeightGridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: AppPad.a12,
        itemCount: MockData.products.length,
        builder: (context, index) {
          final product = MockData.products[index];
          return ProductItemWidget(product: product, productId: index);
        },
      ),
    );
  }
}
