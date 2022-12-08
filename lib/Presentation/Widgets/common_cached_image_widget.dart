import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/Constants/app_constants.dart';
import '../../core/Helpers/shared.dart';

Widget commonCachedImageWidget(
  BuildContext context,
  String imageUrl, {
  double radius = 10.0,
  BoxFit fit = BoxFit.contain,
  double? height,
  double? width,
}) {
  double imageHeight = getWidgetHeight(height!);
  double imageWidth = getWidgetWidth(width!);

  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      height: imageHeight,
      width: imageWidth,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    placeholder: (context, img) => Container(
      height: imageHeight,
      width: imageWidth,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: const Center(
          child: CircularProgressIndicator(
        color: AppConstants.mainColor,
      )),
    ),
    errorWidget: (context, url, error) => ClipOval(
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.fill,
        height: imageHeight,
        width: imageWidth,
      ),
    ),
  );
}
