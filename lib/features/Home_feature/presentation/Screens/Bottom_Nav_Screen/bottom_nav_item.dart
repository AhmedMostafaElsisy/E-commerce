import 'package:flutter/material.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

class BottomBarItem extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;

  const BottomBarItem(
      {Key? key,
      required this.image,
      required this.isSelected,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidgetWidth(48),
      height: getWidgetHeight(50),
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CommonAssetSvgImageWidget(
          imageString: image,
          height: 24,
          width: 24,
          imageColor:
              isSelected ? AppConstants.mainColor : AppConstants.lightGreyColor,
        ),
        getSpaceHeight(AppConstants.smallPadding),
        CommonTitleText(
          textKey: title,
          textWeight: FontWeight.w600,
          textColor:
              isSelected ? AppConstants.mainColor : AppConstants.lightGreyColor,
          textFontSize: AppConstants.xSmallFontSize,
        )
      ]),
    );
  }
}
