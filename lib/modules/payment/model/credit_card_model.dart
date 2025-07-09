import 'package:flutter/animation.dart';

class CreditCardModel {
  final String cardHolderFullName;
  final String cardNumber;
  final String validThru;
  final String? cardType;
  final double? balance;
  final Color? backgroundColor;

  CreditCardModel({
    required this.cardHolderFullName,
    required this.cardNumber,
    required this.validThru,
    this.cardType,
    this.balance,
    this.backgroundColor,
  });
}