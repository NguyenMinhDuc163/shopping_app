import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/modules/reviews/screen/add_review_screen.dart';

import '../../../init.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});
  static const String routeName = '/reviewScreen';
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      isShowBottomButton: false,
      title: "review.title".tr(),
      screen: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: AppPad.h24v10,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "245 ${'review.title'.tr()}",
                          style: AppTextStyles.textContent1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Text(
                              "4.8",
                              style: AppTextStyles.textContent2.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            buildStars(4.8),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          AddReviewScreen.routeName,
                        ),
                    icon: SvgPicture.asset(IconPath.iconModifiy),
                    label: Text(
                      'review.add_review'.tr(),
                      style: AppTextStyles.textContent2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorFF7043,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppGap.h20,
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: MockData.reviews.length,
              itemBuilder: (context, index) {
                final review = MockData.reviews[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            review.avatarUrl.isNotEmpty
                                ? NetworkImage(review.avatarUrl)
                                : null,
                        child:
                            review.avatarUrl.isEmpty
                                ? Icon(Icons.person)
                                : null,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              review.name,
                              style: AppTextStyles.textContent2.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            review.rating.toString(),
                            style: AppTextStyles.textContent2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppGap.w6,
                          Text(
                            "rating",
                            style: AppTextStyles.textContent3.copyWith(
                              color: AppColors.coolGray,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              Text(
                                review.date,
                                style: AppTextStyles.textContent3.copyWith(
                                  color: AppColors.coolGray,
                                ),
                              ),
                              buildStars(review.rating),
                            ],
                          ),
                          Text(review.content),
                        ],
                      ),
                    ),
                    if (index != MockData.reviews.length - 1) AppGap.h10,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.orange, size: 16);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: Colors.orange, size: 16);
        } else {
          return Icon(Icons.star_border, color: Colors.orange, size: 16);
        }
      }),
    );
  }
}
