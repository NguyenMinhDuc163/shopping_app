import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_border_radius.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String cardType;
  final String cardNumber;
  final String cardName;

  const PaymentMethodWidget({
    super.key,
    required this.cardType,
    required this.cardNumber,
    required this.cardName,
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
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              cardType,
              style: TextStyle(
                color: Color(0xFF2A4BA0),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardName, style: AppTextStyles.textContent2),
              Text(
                cardNumber,
                style: AppTextStyles.textContent3.copyWith(
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