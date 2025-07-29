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

class SelectableStarsWidget extends StatefulWidget {
  const SelectableStarsWidget({
    super.key,
    required this.onRatingChanged,
    this.initialRating = 0.0,
    this.starSize = 32.0,
  });

  final Function(double) onRatingChanged;
  final double initialRating;
  final double starSize;

  @override
  State<SelectableStarsWidget> createState() => _SelectableStarsWidgetState();
}

class _SelectableStarsWidgetState extends State<SelectableStarsWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1.0;
            });
            widget.onRatingChanged(_currentRating);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              index < _currentRating ? Icons.star : Icons.star_border,
              color: Colors.orange,
              size: widget.starSize,
            ),
          ),
        );
      }),
    );
  }
}
