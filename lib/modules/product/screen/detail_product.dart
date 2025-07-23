import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/modules/reviews/screen/review_screen.dart';
import '../../../init.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});
  static const String routeName = '/detailProduct';
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int selectedSize = 2;

  final List<String> sizes = ['S', 'M', 'L', 'XL', '2XL'];
  final List<String> thumbnails = [
    ImagePath.productPreview1,
    ImagePath.productPreview2,
    ImagePath.productPreview3,
    ImagePath.productPreview4,
  ];

  // TODO task 1: detail lam lai nhu thiet ke, chon size, color
  // TODO task 2: click brand => ds sp theo brand
  // TODO task 3: 2 nut scroll len no cung di theo, va dang bi de le anh
  // TODO task 4: logo duoi anh sp => brand
  // TODO task 5; tach các widget co du lieu ra
  // TODO task 6: man review => danh gia => star

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      isShowAppBar: true,
      actionsWidget: [SvgPicture.asset(IconPath.iconBag)],
      screen: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(ImagePath.productDetail, fit: BoxFit.fill),
            ),
            Padding(
              padding: AppPad.a16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Men's Printed Pullover Hoodie",
                        style: AppTextStyles.textContent3.copyWith(
                          color: AppColors.coolGray,
                        ),
                      ),
                      Text(
                        "Price",
                        style: AppTextStyles.textContent3.copyWith(
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nike Club Fleece",
                        style: AppTextStyles.textHeader3,
                      ),
                      Text("\$99", style: AppTextStyles.textHeader3),
                    ],
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: thumbnails.length,
                      separatorBuilder: (_, __) => SizedBox(width: 10),
                      itemBuilder:
                          (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              thumbnails[index],
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "review.size".tr(),
                        style: AppTextStyles.textContent1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "review.size_guide".tr(),
                        style: AppTextStyles.textContent3.copyWith(
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: List.generate(sizes.length, (index) {
                      final isSelected = selectedSize == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = index;
                            });
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.black : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.black
                                        : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              sizes[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "review.description".tr(),
                    style: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with Read More..",
                    style: AppTextStyles.textContent3.copyWith(
                      color: AppColors.coolGray,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "review.title".tr(),
                        style: AppTextStyles.textContent1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              ReviewScreen.routeName,
                            ),
                        child: Text(
                          "review.view_all".tr(),
                          style: AppTextStyles.textContent3.copyWith(
                            color: AppColors.coolGray,
                          ),
                        ),
                      ),
                    ],
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
