import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';

class TripStatesWidget extends StatelessWidget {

  const TripStatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      // height: getWidgetHeight(72),
      width: SharedText.screenWidth,
      decoration: BoxDecoration(
        color: AppConstants.lightGreyTextColor,
        borderRadius: BorderRadius.circular(
            AppConstants.containerBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
            getWidgetHeight(AppConstants.pagePadding),
            vertical:
            getWidgetWidth(AppConstants.pagePadding + 4)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CommonAssetSvgImageWidget(
                imageString: "search_car_icon.svg",
                height: 25,
                width: 25,
                fit: BoxFit.contain,
              ),
              getSpaceWidth(AppConstants.smallPadding / 2),
              CommonTitleText(
                textKey: AppLocalizations.of(context)!
                    .lblSearchingForCar,
                textColor: AppConstants.lightBlackColor,
                textWeight: FontWeight.w700,
                textFontSize: AppConstants.smallFontSize,
              ),
            ],
          ),
          getSpaceHeight(AppConstants.smallPadding - 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTitleText(
                textKey: AppLocalizations.of(context)!
                    .lblSearchingForCarTimeEstimation,
                textColor: AppConstants.mainTextColor,
                textWeight: FontWeight.w400,
                textFontSize: AppConstants.normalFontSize,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
