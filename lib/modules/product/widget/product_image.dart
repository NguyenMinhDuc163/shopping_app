import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/core/constants/image_path.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/modules/product/widget/circle_widget.dart';

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
          bottom: -48,
          left: 0,
          right: 0,
          child: SizedBox(
              width: 80,
              height: 110,
              child: CircleWidget(imagePath: IconPath.iconNike,)),
        ),

        // Positioned(
        //   bottom: -30,
        //   left: 0,
        //   right: 0,
        //   child: Center(
        //     child: ClipOval(
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        //         child: Container(
        //           width: 80,
        //           height: 80,
        //           alignment: Alignment.center,
        //           child: Transform.translate(
        //             offset: const Offset(0, -8),
        //             child: SvgPicture.asset(
        //               IconPath.iconNike,
        //               width: 30,
        //               height: 30,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        ...stackChildren,
      ],
    );
  }
}
