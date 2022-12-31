import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';

class CommonProfileHeaderWidget extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final Function() onClick;

  const CommonProfileHeaderWidget(
      {Key? key,
      required this.imageHeight,
      required this.imagePath,
      required this.imageWidth,

      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: getWidgetHeight(24),
        height: getWidgetHeight(24),
        decoration: const BoxDecoration(
          color: AppConstants.lightWhiteColor,
          shape: BoxShape.circle
        ),
        child: Center(
          child: CommonAssetSvgImageWidget(
              imageString: imagePath,
              height: imageHeight,
              width: imageWidth,
             ),
        ),
      ),
    );
  }
}
