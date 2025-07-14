import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/template/button_widget.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/home/widget/search_bar_delegate.dart';
import '../../../init.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final Set<int> favoriteIndexes = {};
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowDrawer: true,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
      titleWidget: Text('common.wishlist'.tr(), style: AppTextStyles.textHeader3,),
      screen: FunctionScreenTemplate(
        isShowBottomButton: false,
        isShowAppBar: false,
        isShowDrawer: true,
        actionsWidget: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
            child: SvgPicture.asset(IconPath.iconBag),
          ),
        ],
        screen: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: AppPad.h24v10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${MockData.products.length} ${'wishlist.items'.tr()}',
                          style: AppTextStyles.textHeader3.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "wishlist.in_wishlist".tr(),
                          style: AppTextStyles.textContent3.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    ButtonWidget(
                      titleWidget: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(IconPath.iconEdit, width: 16, height: 16),
                          SizedBox(width: 4),
                          Text(
                            'wishlist.edit'.tr(),
                            style: AppTextStyles.textContent2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.lightGray,
                      boderRadius: AppBorderRadius.a8,
                      padding: AppPad.h8v4,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: AppPad.a12,
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = MockData.products[index % MockData.products.length];
                  final isFavorite = favoriteIndexes.contains(index);

                  return Container(
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
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                product['image']!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isFavorite) {
                                      favoriteIndexes.remove(index);
                                    } else {
                                      favoriteIndexes.add(index);
                                    }
                                  });
                                },
                                child: SvgPicture.asset(
                                  IconPath.iconHeart,
                                  width: 24,
                                  height: 24,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: AppPad.a8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name']!,
                                style: TextStyle(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                product['price']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
