import 'package:captien_omda_customer/core/Helpers/Extensions/prevent_string_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/Constants/Enums/request_states.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import '../../Home_feature/Domain/enitiy/request_model.dart';

class DriverDataWidget extends StatelessWidget {
  final RequestModel model;

  const DriverDataWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getWidgetHeight(72),
      width: SharedText.screenWidth,
      decoration: BoxDecoration(
        color: model.state == RequestStates.startedRequest
            ? AppConstants.formFillColor
            : AppConstants.lightGreyTextColor,
        borderRadius: BorderRadius.circular(AppConstants.containerBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getWidgetHeight(AppConstants.pagePadding),
            vertical: getWidgetWidth(AppConstants.pagePadding + 4)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ///driver data
          Row(
            children: [
              commonCachedImageWidget(context, model.driverModel!.image!,
                  height: 48, width: 48, isCircular: true, isProfile: true),
              getSpaceWidth(AppConstants.smallPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTitleText(
                    textKey:
                        model.driverModel!.name!.getStringWithoutSpacings(),
                    textFontSize: AppConstants.smallFontSize,
                    textColor: AppConstants.lightBlackColor,
                    textWeight: FontWeight.w600,
                  ),
                  getSpaceHeight(AppConstants.pagePadding - 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonTitleText(
                        textKey: model.carModel!.brand! + model.carModel!.name!,
                        textFontSize: AppConstants.smallFontSize - 2,
                        textColor: AppConstants.mainTextColor,
                        textWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),

          ///trip price
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonTitleText(
                      textKey: double.tryParse(model.driverModel!.rate!)!.toStringAsFixed(2),
                      textFontSize: AppConstants.smallFontSize - 2,
                      textColor: AppConstants.mainTextColor,
                      textWeight: FontWeight.w500,
                    ),
                    getSpaceWidth(4),
                    const CommonAssetSvgImageWidget(
                      imageString: "rate_star.svg",
                      width: 16,
                      height: 16,
                      fit: BoxFit.cover,
                      imageColor: AppConstants.mainColor,
                    ),
                  ],
                ),
                getSpaceHeight(AppConstants.pagePadding - 2),
                CommonTitleText(
                  textKey: model.carModel!.plate!,
                  textColor: AppConstants.mainTextColor,
                  textWeight: FontWeight.w700,
                  textFontSize: AppConstants.smallFontSize - 2,
                ),
              ]),
        ]),
      ),
    );
  }
}
