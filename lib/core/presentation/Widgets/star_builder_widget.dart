import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Function? onRatingChanged;
  final Color color;

  const StarRating({super.key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.color = AppConstants.mainColor,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star,
        color: AppConstants.lightSecondShadowColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: 20,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: 20,
      );
    }
    return InkResponse(
      onTap:
      onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
        List.generate(starCount, (index) => buildStar(context, index)));
  }
}
