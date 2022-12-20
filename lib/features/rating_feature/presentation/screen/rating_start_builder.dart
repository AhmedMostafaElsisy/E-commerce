import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/presentation/Widgets/common_icon_widget.dart';

Widget commonRatingBarBuilder(
    {required void Function(double) onRatingUpdate,
    double? itemSize = 25,
    double? initialRatingValue = 0.0}) {
  return RatingBar.builder(
    initialRating: initialRatingValue!,
    minRating: 0,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: const EdgeInsets.symmetric(horizontal: 7.5),
    itemSize: itemSize!,
    glow: false,

    itemBuilder: (context, index) {
      return commonIcon(
        Icons.star,
        AppConstants.mainColor,
        itemSize,
      );
    },
    onRatingUpdate: onRatingUpdate,
  );
}
