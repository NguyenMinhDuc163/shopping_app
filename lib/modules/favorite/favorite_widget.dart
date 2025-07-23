import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/constants/icon_path.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key, required this.productId});
  final int productId;
  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final Set<int> favoriteIndexes = {};
  @override
  Widget build(BuildContext context) {
    final isFavorite = favoriteIndexes.contains(widget.productId);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isFavorite) {
            favoriteIndexes.remove(widget.productId);
          } else {
            favoriteIndexes.add(widget.productId);
          }
        });
      },
      child: SvgPicture.asset(
        IconPath.iconHeart,
        width: 24,
        height: 24,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
    );
  }
}
