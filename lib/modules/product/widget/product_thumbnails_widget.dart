import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/image_path.dart';

class ProductThumbnailsWidget extends StatefulWidget {
  const ProductThumbnailsWidget({super.key});

  @override
  State<ProductThumbnailsWidget> createState() =>
      _ProductThumbnailsWidgetState();
}

class _ProductThumbnailsWidgetState extends State<ProductThumbnailsWidget> {
  final List<String> thumbnails = [
    ImagePath.productPreview1,
    ImagePath.productPreview2,
    ImagePath.productPreview3,
    ImagePath.productPreview4,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: thumbnails.length,
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemBuilder:
            (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                thumbnails[index],
                fit: BoxFit.fill,
              ),
            ),
      ),
    );
  }
}
