import 'package:shopping_app/core/widgets/app_gap.dart';
import 'package:shopping_app/modules/reviews/model/review_model.dart';
import 'package:shopping_app/modules/reviews/widget/stars_widget.dart';

import '../../../init.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget({super.key, required this.reviewModel});
  final ReviewModel reviewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.coolGray.withOpacity(0.3),
              backgroundImage:
                  reviewModel.avatarUrl.isNotEmpty
                      ? NetworkImage(reviewModel.avatarUrl)
                      : null,
              child:
                  reviewModel.avatarUrl.isEmpty
                      ? Icon(Icons.person, color: AppColors.coolGray)
                      : null,
            ),
            AppGap.w12,
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reviewModel.name,
                          style: AppTextStyles.textContent2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppGap.h4,
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.coolGray,
                            ),
                            AppGap.w4,
                            Text(
                              reviewModel.date,
                              style: AppTextStyles.textContent3.copyWith(
                                color: AppColors.coolGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            reviewModel.rating.toString(),
                            style: AppTextStyles.textContent2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppGap.w4,
                          Text(
                            "rating",
                            style: AppTextStyles.textContent3.copyWith(
                              color: AppColors.coolGray,
                            ),
                          ),
                        ],
                      ),
                      AppGap.h4,
                      StarsWidget(rating: reviewModel.rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          reviewModel.content,
          style: AppTextStyles.textContent3.copyWith(color: AppColors.coolGray),
        ),
      ],
    );
  }
}
