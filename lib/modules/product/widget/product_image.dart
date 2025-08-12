import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/core/constants/image_path.dart';

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
        // Positioned(
        //   bottom: -48,
        //   left: 0,
        //   right: 0,
        //   child: SizedBox(
        //       width: 80,
        //       height: 110,
        //       child: CircleWidget(imagePath: IconPath.iconNike,)),
        // ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: ClipPath(
              clipper: BrandContainerClipper(),
              child: Container(
                width: 80,
                height: 49,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10),
                child: SvgPicture.asset(
                  IconPath.iconNike,
                  width: 48,
                  height: 25,
                ),
              ),
            ),
          ),
        ),
        ...stackChildren,
      ],
    );
  }
}
/// https://fluttershapemaker.com/#/
class BrandContainerClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0,40);
    path_0.cubicTo(0,17.9086,17.9086,0,40,0);
    path_0.cubicTo(62.0914,0,80,17.9086,80,40);
    path_0.lineTo(80,49);
    path_0.lineTo(0,49);
    path_0.lineTo(0,40);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}