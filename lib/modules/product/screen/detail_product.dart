import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/modules/product/widget/appbar_product_widget.dart';
import 'package:shopping_app/modules/product/widget/color_selection_widget.dart';
import 'package:shopping_app/modules/product/widget/description_widget.dart';
import 'package:shopping_app/modules/product/widget/product_info_widget.dart';
import 'package:shopping_app/modules/product/widget/product_thumbnails_widget.dart';
import 'package:shopping_app/modules/product/widget/row_header_widget.dart';
import 'package:shopping_app/modules/product/widget/size_selection_widget.dart';
import 'package:shopping_app/modules/reviews/screen/review_screen.dart';

import '../../../init.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});
  static const String routeName = '/detailProduct';
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  // TODO task 1: detail lam lai nhu thiet ke, chon size, color
  // TODO task 2: click brand => ds sp theo brand
  /// TODO task 3: 2 nut scroll len no cung di theo, va dang bi de le anh
  // TODO task 4: logo duoi anh sp => brand
  // TODO task 5; tach các widget co du lieu ra
  // TODO task 6: man review => danh gia => star
  /// TODO task 7: price va gia tiem cam trai
  // TODO task 8: tach cac widget co du lieu ra

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowAppBar: false,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
      screen: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  ImagePath.productDetail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                AppbarProductWidget(),
              ],
            ),
            ProductInfoWidget(),
            Padding(
              padding: AppPad.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ProductThumbnailsWidget(),
                  RowHeaderWidget(
                    title: "review.size".tr(),
                    value: "review.size_guide".tr(),
                  ),

                  SizeSelectionWidget(),
                  RowHeaderWidget(
                    title: "detail_product.color".tr(),
                    value: "detail_product.only_left".tr(
                      namedArgs: {'number': '3'},
                    ),
                  ),
                  ColorSelectionWidget(),
                  DescriptionWidget(),

                  RowHeaderWidget(
                    title: "review.title".tr(),
                    value: "review.view_all".tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
