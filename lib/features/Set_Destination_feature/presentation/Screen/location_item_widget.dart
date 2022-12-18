import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class LocationItemWidget extends StatelessWidget {
  final String imagePath;
  final String mainTitle;
  final String subTitle;

  const LocationItemWidget(
      {Key? key, required this.subTitle, required this.mainTitle,required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         CommonAssetSvgImageWidget(
          imageString: imagePath,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
        ),
        getSpaceWidth(AppConstants.smallPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getWidgetWidth(350),
                height: getWidgetHeight(17),
                child: CommonTitleText(
                  textKey: mainTitle,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.smallFontSize,
                  minTextFontSize: AppConstants.smallFontSize,
                  textAlignment: TextAlign.start,
                ),
              ),
              getSpaceHeight(AppConstants.smallPadding),
              SizedBox(
                width: getWidgetWidth(320),
                height: getWidgetHeight(17),
                child: CommonTitleText(
                  textKey: subTitle,
                  textColor: AppConstants.mainTextColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.xSmallFontSize,
                  minTextFontSize: AppConstants.xSmallFontSize,
                  textAlignment: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
