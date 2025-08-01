import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/core/constants/image_path.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, this.stackChildren = const []});
  final List<Widget> stackChildren;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImagePath.productDetail,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: -24,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.colorD9E3DC,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                IconPath.iconNike,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),
        ...stackChildren
      ],
    );
  }
}
