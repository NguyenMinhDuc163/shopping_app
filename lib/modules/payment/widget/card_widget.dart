import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/image_path.dart';
import 'package:shopping_app/core/constants/mock_data.dart';
import 'package:shopping_app/core/theme/app_pad.dart';
import 'package:u_credit_card/u_credit_card.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: SizedBox(
        height: 185,
        child: PageView.builder(
          controller: PageController(
            viewportFraction: 0.85,
            initialPage: 0,
          ),
          itemCount: MockData.cards.length,
          padEnds: false,
          itemBuilder: (context, index) {
            final card = MockData.cards[index];
            return Padding(
              padding: AppPad.h12,
              child: CreditCardUi(
                width: 300,
                cardHolderFullName: card.cardHolderFullName,
                cardNumber: card.cardNumber,
                validThru: card.validThru,
                cardType: CardType.giftCard,
                backgroundDecorationImage: DecorationImage(
                    image: AssetImage(ImagePath.imgCardBackground),
                    fit: BoxFit.fill
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
