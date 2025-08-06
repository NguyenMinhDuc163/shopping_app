import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final String address;

  const DeliveryAddressWidget({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xFFF6F2FF),
            borderRadius: AppBorderRadius.a12,
          ),
          child: Center(
            child: Icon(Icons.location_on, color: Color(0xFFFF7A00)),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address,
                style: AppTextStyles.textContent2.copyWith(
                  color: AppColors.coolGray,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.check_circle, color: Colors.green, size: 30),
      ],
    );
  }
} 