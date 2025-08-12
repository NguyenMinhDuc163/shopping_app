import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/sliver_pad_to_box.dart';
import 'package:shopping_app/init.dart';
import 'package:shopping_app/modules/cart/screen/cart_screen.dart';
import 'package:shopping_app/modules/home/widget/search_bar_delegate.dart';
import 'package:shopping_app/modules/product/screen/detail_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> favoriteIndexes = {};
  // TODO Task 2: SliverToBoxAdapter + padding => ?
  // TODO Task 3: neu noi dung ben trong nho hon thi no se co len nhung tong the khong thay doi
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowAppBar: true,
      isShowDrawer: true,
      actionsWidget: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
          child: SvgPicture.asset(IconPath.iconBag),
        ),
      ],
      screen: CustomScrollView(
        slivers: [
          SliverPadToBox(
            padding: AppPad.h22v15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nguyen Duc',
                  style: AppTextStyles.textHeader2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Welcome to Laza.',
                  style: AppTextStyles.textContent3.copyWith(
                    color: AppColors.coolGray,
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(pinned: true, delegate: SearchBarDelegate()),

          SliverPadToBox(
            padding: AppPad.h22v15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose Brand',
                  style: AppTextStyles.textContent1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('View All', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: AppPad.h16,
                    itemCount: MockData.brands.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final brand = MockData.brands[index];
                      return Container(
                        padding: AppPad.h16v8,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: AppBorderRadius.a16,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: AppPad.a14,
                              decoration: BoxDecoration(
                                borderRadius: AppBorderRadius.a12,
                                color: Colors.white,
                              ),
                              child: SvgPicture.asset(brand['icon']),
                            ),
                            SizedBox(width: 8),
                            Text(
                              brand['name'],
                              style: AppTextStyles.textHeader3.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SliverPadToBox(
            padding: AppPad.a16, // tinh lai padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Arrival',
                  style: AppTextStyles.textContent1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text('View All', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, rowIndex) {
              final int totalItems = MockData.products.length;
              final int itemsPerRow = 2;
              final int totalRows = (totalItems / itemsPerRow).ceil();

              if (rowIndex >= totalRows) return null;

              final int startIndex = rowIndex * itemsPerRow;
              final int endIndex = (startIndex + itemsPerRow).clamp(0, totalItems);
              final List<Widget> rowItems = [];

              for (int i = startIndex; i < endIndex; i++) {
                final product = MockData.products[i];
                final isFavorite = favoriteIndexes.contains(i);

                rowItems.add(
                  Flexible(
                    child: GestureDetector(
                      onTap:
                          () => Navigator.pushNamed(
                        context,
                        DetailProduct.routeName,
                      ),
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
                            if ((product['image'] ?? '').isNotEmpty)
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      product['image']!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isFavorite) {
                                            favoriteIndexes.remove(i);
                                          } else {
                                            favoriteIndexes.add(i);
                                          }
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        IconPath.iconHeart,
                                        width: 24,
                                        height: 24,
                                        color:
                                        isFavorite
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            Visibility(
                              visible: (product['name'] ?? '').isNotEmpty || (product['price'] ?? '').isNotEmpty,
                              child: Padding(
                                padding: AppPad.a8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if ((product['name'] ?? '').isNotEmpty)
                                      Text(
                                        product['name']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    if ((product['name'] ?? '').isNotEmpty &&
                                        (product['price'] ?? '').isNotEmpty)
                                      SizedBox(height: 4),
                                    if ((product['price'] ?? '').isNotEmpty)
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              while (rowItems.length < itemsPerRow) {
                rowItems.add(Flexible(child: SizedBox()));
              }

              return Padding(
                padding: AppPad.a12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rowItems,
                ),
              );
            }, childCount: (MockData.products.length * 3 / 2).ceil()),
          ),
        ],
      ),
    );
  }
}
