import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/init.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> favoriteIndexes = {};

  final List<Map<String, dynamic>> brands = [
    {'icon': IconPath.iconAdidas, 'name': 'Adidas'},
    {'icon': IconPath.iconNike, 'name': 'Nike'},
    {'icon': IconPath.iconFila, 'name': 'Fila'},
    {'icon': IconPath.iconAdidas, 'name': 'Adidas'},
    {'icon': IconPath.iconNike, 'name': 'Nike'},
    {'icon': IconPath.iconFila, 'name': 'Fila'},
  ];

  final products = [
    {
      'image': ImagePath.imgMock1,
      'name': 'Nike Sportswear Club Fleece',
      'price': '\$99',
    },
    {
      'image': ImagePath.imgMock2,
      'name': 'Trail Running Jacket Nike Windrunner',
      'price': '\$80',
    },
    {'image': ImagePath.imgMock3, 'name': 'Nike Hoodie', 'price': '\$60'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
  ];
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowAppBar: true,
      isShowDrawer: true,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
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
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(),
          ),
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
                    itemCount: brands.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final brand = brands[index];
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
                final product = products[index % products.length];
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
                              height: 160,
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
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 70;
  @override
  double get maxExtent => 70;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: AppPad.h16v8,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.a12,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFB89EFF),
              borderRadius: AppBorderRadius.a12,
            ),
            padding: AppPad.a12,
            child: Icon(Icons.mic, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}