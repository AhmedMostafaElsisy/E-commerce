import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';

class TripLocationItem extends StatelessWidget {
  final String currentLocation;
  final String destinationLocation;

  const TripLocationItem(
      {Key? key,
      required this.currentLocation,
      required this.destinationLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonAssetSvgImageWidget(
                imageString: "location_to_icon.svg",
                fit: BoxFit.contain,
                height: 32,
                width: 32),
            SizedBox(
              height: getWidgetHeight(50),
              width: getWidgetWidth(2),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 1,
                      height: 5,
                      decoration: BoxDecoration(
                          color: AppConstants.mainTextColor,
                          borderRadius: BorderRadius.circular(
                              AppConstants.containerBorderRadius)),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return getSpaceHeight(1.5);
                  },
                  itemCount: 7),
            ),
            const CommonAssetSvgImageWidget(
                imageString: "location_from_icon.svg",
                fit: BoxFit.contain,
                height: 32,
                width: 32),
          ],
        ),
        getSpaceWidth(AppConstants.smallPadding),
        Expanded(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getWidgetWidth(350),
                    child: CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblCurrentLocation,
                      textColor: AppConstants.lightBlackColor,
                      textWeight: FontWeight.w600,
                      textFontSize: AppConstants.normalFontSize,
                      minTextFontSize: AppConstants.normalFontSize,
                      textAlignment: TextAlign.start,
                    ),
                  ),
                  getSpaceHeight(AppConstants.smallPadding - 2),
                  SizedBox(
                    width: getWidgetWidth(320),
                    child: CommonTitleText(
                      textKey: currentLocation,
                      textColor: AppConstants.mainTextColor,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.smallFontSize,
                      minTextFontSize: AppConstants.smallFontSize,
                      textAlignment: TextAlign.start,
                    ),
                  ),
                ],
              ),
              getSpaceHeight(30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getWidgetWidth(350),
                    child: CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblCurrentLocation,
                      textColor: AppConstants.lightBlackColor,
                      textWeight: FontWeight.w600,
                      textFontSize: AppConstants.normalFontSize,
                      minTextFontSize: AppConstants.normalFontSize,
                      textAlignment: TextAlign.start,
                    ),
                  ),
                  getSpaceHeight(AppConstants.smallPadding - 2),
                  SizedBox(
                    width: getWidgetWidth(320),
                    child: CommonTitleText(
                      textKey: destinationLocation,
                      textColor: AppConstants.mainTextColor,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.smallFontSize,
                      minTextFontSize: AppConstants.smallFontSize,
                      textAlignment: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
