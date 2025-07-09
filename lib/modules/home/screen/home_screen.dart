import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
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
          SliverToBoxAdapter(
            child: Padding(
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
          ),
          SliverPersistentHeader(pinned: true, delegate: SearchBarDelegate()),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
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

          SliverToBoxAdapter(
            child: Padding(
              padding: AppPad.a16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Arrival',
                    style: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('View All', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: AppPad.a12,
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final product =
                    MockData.products[index % MockData.products.length];
                final isFavorite = favoriteIndexes.contains(index);

                return GestureDetector(
                  onTap:
                      () =>
                          Navigator.pushNamed(context, DetailProduct.routeName),
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
    );
  }
}
