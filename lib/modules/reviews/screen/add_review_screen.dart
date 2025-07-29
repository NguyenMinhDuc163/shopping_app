import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';
import 'package:shopping_app/core/widgets/template/function_screen_template.dart';
import 'package:shopping_app/core/widgets/text_input_custom.dart';
import 'package:shopping_app/modules/dashboard/screen/dashboard_screen.dart';
import 'package:shopping_app/modules/reviews/widget/stars_widget.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});
  static const String routeName = '/addReview';
  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  double _starValue = 2.5;

  @override
  Widget build(BuildContext context) {
    return FunctionScreenTemplate(
      title: 'review.title'.tr(),
      titleButtonBottom: "review.submit_review".tr(),
      onClickBottomButton:
          () => Navigator.pushNamed(context, DashboardScreen.routeName),
      screen: Padding(
        padding: AppPad.h24v10,
        child: Column(
          spacing: 30,
          children: [
            TextInputCustom(
              label: 'review.name'.tr(),
              hintText: 'review.type_your_name'.tr(),
              titleStyle: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
              fillColor: true,
              controller: nameController,
            ),

            TextInputCustom(
              label: 'review.how_was_your_experience'.tr(),
              hintText: 'review.describe_your_experience'.tr(),
              titleStyle: AppTextStyles.textContent1.copyWith(
                fontWeight: FontWeight.bold,
              ),
              fillColor: true,
              maxLines: 8,
              controller: descriptionController,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "review.star".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SelectableStarsWidget(
                    initialRating: _starValue,
                    starSize: 48.0,
                    onRatingChanged: (rating) {
                      setState(() {
                        _starValue = rating;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "${_starValue.toInt()}/5",
                    style: AppTextStyles.textContent1.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
