import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Helpers/shared.dart';

Widget commonAssetSvgImageWidget({
  required String imageString,
  required double height,
  required double width,
  Color? imageColor,
  double radius = 0.0,
  BoxFit? fit = BoxFit.contain,
  final Function()? onTapImage,
}) {
  return InkWell(
    onTap: onTapImage,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SvgPicture.asset(
        'assets/images/$imageString',
        fit: fit!,
        color: imageColor,
        height: getWidgetHeight(height),
        width: getWidgetWidth(width),
      ),
    ),
  );
}
