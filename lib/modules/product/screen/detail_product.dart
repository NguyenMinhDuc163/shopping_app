import 'package:disposable_provider/disposable_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';
import 'package:shopping_app/modules/product/bloc/detail_product_controller.dart';
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

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});
  static const String routeName = '/detailProduct';

  @override
  Widget build(BuildContext context) {
    return DisposableProvider(create: (BuildContext context) {
      return DetailProductController();
    },
    child: _DetailProductContent());
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



/// 5/8
/// cart_screen
// ToDo khong can doi mau khi chon san pham
// TODO vung an
/// TODO tim hieu  shrinkWrap
/// TODO chuyen screen thanh customScrollView'
/// cart_item_widget
/// TODO thay itemWidget thanh  AssetIconSvg
/// address_form_screen
///todo controllers extent disposeeble controllers => nhom 16 - 20
///payment_method_screen
/// TODO scroll full card
///  todo controllers extent disposeeble controllers => nhom
/// TODO kheo den 1 phan se tu chuyen sang card khac
class _DetailProductContent extends StatelessWidget {
  const _DetailProductContent();



  @override
  Widget build(BuildContext context) {
    final DetailProductController controller = DisposableProvider.of<DetailProductController>(context);

    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowAppBar: false,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
      screen: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(stackChildren: [AppbarProductWidget()]),
            ProductInfoWidget(product: controller.product),
            Padding(
              padding: AppPad.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  ProductThumbnailsWidget(),
                  RowHeaderWidget(title: "review.size".tr(), value: "review.size_guide".tr()),

                  ValueListenableBuilder<int>(
                    valueListenable: controller.selectedSizeIndex,
                    builder: (context, selectedSizeIndex, child) {
                      return SelectionWidget<String>(
                        items: controller.product.sizes,
                        onSelectionChanged: controller.onSizeChanged,
                        selectedIndex: selectedSizeIndex,
                        isItemAvailable: controller.isSizeAvailable,
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
                    valueListenable: controller.selectedColorIndex,
                    builder: (context, selectedColorIndex, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowHeaderWidget(
                            title: "detail_product.color".tr(),
                            value: controller.getQuantityText(),
                            valueStyle: controller.getQuantityTextStyle(),
                            isShowIcon: true,
                          ),
                          SelectionWidget<ColorModel>(
                            items: controller.product.colors,
                            onSelectionChanged: controller.onColorChanged,
                            selectedIndex: selectedColorIndex,
                            isItemAvailable: controller.isColorAvailable,
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
                  DescriptionWidget(product: controller.product),

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
