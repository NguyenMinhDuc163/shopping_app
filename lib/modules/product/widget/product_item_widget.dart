import 'package:shopping_app/modules/favorite/favorite_widget.dart';
import 'package:shopping_app/modules/product/screen/detail_product.dart';

import '../../../init.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key, required this.product, required this.productId});
  final Map<String, String> product;
  final int productId;
  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, DetailProduct.routeName),
      child: Container(
        margin: AppPad.a8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppBorderRadius.a16,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if ((widget.product['image'] ?? '').isNotEmpty)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.product['image']!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FavoriteWidget(productId: widget.productId),
                  ),
                ],
              ),
            Visibility(
              visible:
              (widget.product['name'] ?? '').isNotEmpty ||
                  (widget.product['price'] ?? '').isNotEmpty,
              child: Padding(
                padding: AppPad.a8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((widget.product['name'] ?? '').isNotEmpty)
                      Text(
                        widget.product['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if ((widget.product['name'] ?? '').isNotEmpty &&
                        (widget.product['price'] ?? '').isNotEmpty)
                      SizedBox(height: 4),
                    if ((widget.product['price'] ?? '').isNotEmpty)
                      Text(
                        widget.product['price']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
