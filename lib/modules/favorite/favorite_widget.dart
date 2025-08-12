import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';
import 'package:shopping_app/modules/favorite/favorite_notifier.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = FavoriteNotifier();

    return GestureDetector(
      onTap: () => favoriteNotifier.changeColor(),
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: favoriteNotifier,
            builder: (context, isFavorite, child) {
              return SvgPicture.asset(
                IconPath.iconHeart,
                width: 24,
                height: 24,
                color: isFavorite ? Colors.red : Colors.grey,
              );
            },
          ),
        ],
      ),
    );
  }
}
