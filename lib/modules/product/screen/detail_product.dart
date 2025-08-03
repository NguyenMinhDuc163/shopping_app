import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';
import 'package:shopping_app/modules/product/widget/appbar_product_widget.dart';
import 'package:shopping_app/modules/product/widget/description_widget.dart';
import 'package:shopping_app/modules/product/widget/product_image.dart';
import 'package:shopping_app/modules/product/widget/product_info_widget.dart';
import 'package:shopping_app/modules/product/widget/product_thumbnails_widget.dart';
import 'package:shopping_app/modules/product/widget/row_header_widget.dart';
import 'package:shopping_app/modules/product/widget/selection_widget.dart';
import 'package:shopping_app/modules/reviews/screen/review_screen.dart';
import 'package:shopping_app/modules/reviews/widget/review_item_widget.dart';
import 'package:shopping_app/modules/product/notifier/detail_product_notifier.dart';

import '../../../init.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});
  static const String routeName = '/detailProduct';

  @override
  Widget build(BuildContext context) {
    return _DetailProductContent();
  }
}

/// 23/7
/// TODO task 1: click brand => ds sp theo brand
/// TODO task 2: 2 nut scroll len no cung di theo, va dang bi de le anh
/// TODO task 3: logo duoi anh sp => brand
/// TODO task 4: price va gia tien can trai
/// TODO task 5; tach các widget co du lieu ra
/// TODO task 6: detail lam lai nhu thiet ke, chon size, color

/// 30/7
/// TODO task 1 custom paint,blur
/// TODO task 2 xy ly khi het S, color het hang
/// TODO task 3  uu truy van bang Map
/// TODO task 4  dụng ValueNotifier
/// TODO task 5  generic
/// TODO task 6 them icon o color

class _DetailProductContent extends StatelessWidget {
  _DetailProductContent();

  final DetailProductNotifier _notifier = DetailProductNotifier();

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
            ProductImage(stackChildren: [AppbarProductWidget()]),
            ProductInfoWidget(product: _notifier.product),
            Padding(
              padding: AppPad.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ProductThumbnailsWidget(),
                  RowHeaderWidget(title: "review.size".tr(), value: "review.size_guide".tr()),

                  ValueListenableBuilder<int>(
                    valueListenable: _notifier.selectedSizeIndex,
                    builder: (context, selectedSizeIndex, child) {
                      return SelectionWidget<String>(
                        items: _notifier.product.sizes,
                        onSelectionChanged: _notifier.onSizeChanged,
                        initialSelectedIndex: selectedSizeIndex,
                        isItemAvailable: _notifier.isSizeAvailable,
                        itemBuilder: (size, isSelected, isAvailable) {
                          return Text(
                            size,
                            style: TextStyle(
                              color: isAvailable ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  ValueListenableBuilder<int>(
                    valueListenable: _notifier.selectedColorIndex,
                    builder: (context, selectedColorIndex, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowHeaderWidget(
                            title: "detail_product.color".tr(),
                            value: _notifier.getQuantityText(),
                            valueStyle: _notifier.getQuantityTextStyle(),
                            isShowIcon: true,
                          ),
                          SelectionWidget<ColorModel>(
                            items: _notifier.product.colors,
                            onSelectionChanged: _notifier.onColorChanged,
                            initialSelectedIndex: selectedColorIndex,
                            isItemAvailable: _notifier.isColorAvailable,
                            itemBuilder: (color, isSelected, isAvailable) {
                              return Container(
                                margin: isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color:
                                      isAvailable ? (color.color) : (color.color.withOpacity(0.8)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  DescriptionWidget(product: _notifier.product),

                  RowHeaderWidget(
                    title: "review.title".tr(),
                    value: "review.view_all".tr(),
                    onTap: () => Navigator.pushNamed(context, ReviewScreen.routeName),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ReviewItemWidget(reviewModel: MockData.reviews[0]),
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
