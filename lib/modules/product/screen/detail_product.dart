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

import '../../../init.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});
  static const String routeName = '/detailProduct';

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  /// TODO task 1: click brand => ds sp theo brand
  /// TODO task 2: 2 nut scroll len no cung di theo, va dang bi de le anh
  /// TODO task 3: logo duoi anh sp => brand
  /// TODO task 4: price va gia tien can trai
  /// TODO task 5; tach các widget co du lieu ra
  /// TODO task 6: detail lam lai nhu thiet ke, chon size, color

  /// TODO custom paint,blur
  //TODO xy ly khi het S, color het hang
  // TODO toi uu truy van bang Map
  /// TODO sử dụng ValueNotifier
  /// TODO dung generic
  // TODO them icon o color

  int selectedSizeIndex = 0;
  int selectedColorIndex = 0;

  late ProductModel product;
  @override
  void initState() {
    super.initState();
    product = MockData.mockProduct;
    _setDefaultSizeColor();
  }

  void _setDefaultSizeColor() {
    bool foundColor = false;

    for (int colorIndex = 0; colorIndex < product.colors.length; colorIndex++) {
      for (int sizeIndex = 0; sizeIndex < product.sizes.length; sizeIndex++) {
        int quantity = product.getQuantity(sizeIndex, colorIndex);
        if (quantity > 0) {
          selectedColorIndex = colorIndex;
          selectedSizeIndex = sizeIndex;
          foundColor = true;
          break;
        }
      }
      if (foundColor) break;
    }
  }

  void _onSizeChanged(int sizeIndex) {
    setState(() {
      selectedSizeIndex = sizeIndex;
    });
  }

  void _onColorChanged(int colorIndex) {
    setState(() {
      selectedColorIndex = colorIndex;
    });
  }

  int _getCurrentQuantity() {
    return product.getQuantity(selectedSizeIndex, selectedColorIndex);
  }

  String _getQuantityText() {
    final quantity = _getCurrentQuantity();

    if (quantity > 5) {
      return "";
    } else if (quantity == 5) {
      return "detail_product.in_stock".tr(
        namedArgs: {'number': quantity.toString()},
      );
    } else {
      return "detail_product.only_left".tr(
        namedArgs: {'number': quantity.toString()},
      );
    }
  }

  TextStyle? _getQuantityTextStyle() {
    final quantity = _getCurrentQuantity();

    if (quantity > 5) {
      return null;
    } else if (quantity == 5) {
      return AppTextStyles.textContent3.copyWith(color: AppColors.coolGray);
    } else {
      return AppTextStyles.textContent3.copyWith(color: AppColors.error);
    }
  }

  bool _isSizeAvailable(int sizeIndex) {
    return product.getQuantity(sizeIndex, selectedColorIndex) > 0;
  }

  bool _isColorAvailable(int colorIndex) {
    return product.getQuantity(selectedSizeIndex, colorIndex) > 0;
  }

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
            ProductInfoWidget(product: product),
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

                  SelectionWidget<String>(
                    items: product.sizes,
                    onSelectionChanged: _onSizeChanged,
                    initialSelectedIndex: selectedSizeIndex,
                    isItemAvailable: _isSizeAvailable,
                    itemBuilder: (size, isSelected, isAvailable) {
                      return Text(
                        size,
                        style: TextStyle(
                          color: isAvailable ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),

                  RowHeaderWidget(
                    title: "detail_product.color".tr(),
                    value: _getQuantityText(),
                    valueStyle: _getQuantityTextStyle(),
                    isShowIcon: true,
                  )
                  ,
                  SelectionWidget<ColorModel>(
                    items: product.colors,
                    onSelectionChanged: _onColorChanged,
                    initialSelectedIndex: selectedColorIndex,
                    isItemAvailable: _isColorAvailable,
                    itemBuilder: (color, isSelected, isAvailable) {
                      return Container(
                        margin: isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: isAvailable ? (color.color) : (color.color.withOpacity(0.8)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  ),
                  DescriptionWidget(product: product),

                  RowHeaderWidget(
                    title: "review.title".tr(),
                    value: "review.view_all".tr(),
                    onTap:
                        () => Navigator.pushNamed(context, ReviewScreen.routeName,),
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
