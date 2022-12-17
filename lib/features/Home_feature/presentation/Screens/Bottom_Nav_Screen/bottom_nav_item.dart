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
      width: getWidgetWidth(120),
      height: getWidgetHeight(40),
      decoration: BoxDecoration(
          color: isSelected? AppConstants.mainColor:AppConstants.lightWhiteColor,
          borderRadius:
              BorderRadius.circular(AppConstants.bottomSheetBorderRadius)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isSelected)
          commonAssetSvgImageWidget(imageString: image, height: 24, width: 24),
        getSpaceWidth(AppConstants.smallPadding),
        CommonTitleText(
          textKey: title,
          textWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          textColor: isSelected
              ? AppConstants.lightWhiteColor
              : AppConstants.lightBlackColor,
          textFontSize: AppConstants.smallFontSize,
        )
      ]),
    );
  }
}
