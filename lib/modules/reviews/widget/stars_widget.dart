import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key, required this.rating});
  final double rating;
  @override
  Widget build(BuildContext context) {
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
