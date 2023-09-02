import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import 'common_asset_image_widget.dart';
import 'common_asset_svg_image_widget.dart';

Widget commonCachedImageWidget(
  String imageUrl,  {
  double radius = 0.0,
  BoxFit fit = BoxFit.fill,
  required double height,
  required double width,
  bool isCircular = false,
  bool isProfile = false,
}) {
  double imageHeight = getWidgetHeight(height);
  double imageWidth =
      isCircular ? getWidgetHeight(height) : getWidgetWidth(width);

  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      height: imageHeight,
      width: imageWidth,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
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
    errorWidget: (context, url, error) => isProfile
        ? commonAssetImageWidget(
            imageString: 'avatar.png',
      height: height,
      width: width,
            radius: radius,
            fit: fit,
          )
        : CommonAssetSvgImageWidget(
            imageString: 'logo.svg',
            height: height,
            width: width,
            fit: fit,
            radius: radius,
            isCircular: isCircular,
          ),
  );
}
