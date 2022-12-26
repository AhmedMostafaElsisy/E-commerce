import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
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
    return SizedBox(
      width: getWidgetWidth(50),
      height: getWidgetHeight(55),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        commonAssetImageWidget(
          imageString: image,
          height: 24,
          width: 24,
          imageColor: isSelected
              ? AppConstants.mainColor
              : AppConstants.lightBorderColor,
        ),
        getSpaceWidth(AppConstants.smallPadding - 2),
        CommonTitleText(
          textKey: title,
          textWeight: FontWeight.w600,
          textColor: isSelected
              ? AppConstants.mainColor
              : AppConstants.lightBorderColor,
          textFontSize: AppConstants.smallFontSize,
        )
      ]),
    );
  }
}
