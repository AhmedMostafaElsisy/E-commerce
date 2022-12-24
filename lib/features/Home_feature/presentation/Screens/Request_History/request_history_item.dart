import 'package:captien_omda_customer/core/Helpers/Extensions/prevent_string_spacing.dart';
import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/request_model.dart';
import 'package:flutter/material.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/Constants/Enums/request_states.dart';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared_texts.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';

class RequestHistoryItem extends StatelessWidget {
  final RequestModel model;

  const RequestHistoryItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: SharedText.screenWidth,
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          boxShadow: [
            BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.25),
                blurRadius: 4.0,
                offset: const Offset(0, 0))
          ],
          borderRadius:
          BorderRadius.circular(AppConstants.containerBorderRadius)),
      padding: const EdgeInsets.all(AppConstants.pagePadding),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            ///driver data
            if( model.driverModel !=null)...[
              Row(
                children: [
                  commonCachedImageWidget(context,  model.driverModel!.image!,
                      height: 38, width: 38, isCircular: true, isProfile: true),
                  getSpaceWidth(AppConstants.smallPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTitleText(
                        textKey: model.driverModel!.name!.getStringWithoutSpacings(),
                        textFontSize: AppConstants.smallFontSize,
                        textColor: AppConstants.lightBlackColor,
                        textWeight: FontWeight.w600,
                      ),
                      getSpaceHeight(AppConstants.smallPadding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          CommonTitleText(
                            textKey:double.tryParse(model.driverModel!.rate!)!.toStringAsFixed(2),
                            textFontSize: AppConstants.smallFontSize - 2,
                            textColor: AppConstants.mainTextColor,
                            textWeight: FontWeight.w500,
                          ),
                          const    CommonAssetSvgImageWidget(
                            imageString: "rate_star.svg",
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                            imageColor: AppConstants.starRatingColor,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

            ]else...[
              const SizedBox(),
            ],

            ///trip price
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(model.state == RequestStates.cancelRequest)...[
                    CommonTitleText(
                      textKey:
                      AppLocalizations.of(context)!.lblCancelRequest,
                      textColor: AppConstants.lightBorderColor,
                      textWeight: FontWeight.w700,
                      textFontSize: AppConstants.normalFontSize,
                    ),
                  ] else
                    ...[
                      const CommonAssetSvgImageWidget(
                        imageString: "cash_icon.svg",
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                        imageColor: AppConstants.lightBorderColor,
                      ),
                      getSpaceWidth(AppConstants.smallPadding / 2),
                      CommonTitleText(
                        textKey:
                        "${model.price!} ${AppLocalizations.of(context)!.lblEGP}",
                        textColor: AppConstants.lightBorderColor,
                        textWeight: FontWeight.w700,
                        textFontSize: AppConstants.normalFontSize,
                      ),
                    ]

                ]),
          ],
        ),

        ///spacer
        getSpaceHeight(AppConstants.smallPadding),

        ///spacer
        const Divider(
          color: AppConstants.lightGrayColor,
          thickness: 1,
        ),

        ///spacer
        getSpaceHeight(AppConstants.smallPadding),

        ///trip start location
        Row(
          children: [
            const CommonAssetSvgImageWidget(
                imageString: "current_location.svg",
                fit: BoxFit.contain,
                height: 24,
                width: 24),
            getSpaceWidth(AppConstants.smallPadding),
            SizedBox(
              width: getWidgetWidth(250),
              child: CommonTitleText(
                textKey: model.fromLocation!.locationName!,
                textColor: AppConstants.lightBlackColor,
                textWeight: FontWeight.w600,
                textFontSize: AppConstants.normalFontSize,
                minTextFontSize: AppConstants.normalFontSize,
                textAlignment: TextAlign.start,
              ),
            ),
          ],
        ),

        ///spacer
        getSpaceHeight(AppConstants.pagePadding - 4),

        ///trip end location

        Row(
          children: [
            const CommonAssetSvgImageWidget(
                imageString: "to_location.svg",
                fit: BoxFit.contain,
                height: 24,
                width: 24),
            getSpaceWidth(AppConstants.smallPadding),
            SizedBox(
              width: getWidgetWidth(250),
              child: CommonTitleText(
                textKey: model.toLocation!.locationName!,
                textColor: AppConstants.lightBlackColor,
                textWeight: FontWeight.w600,
                textFontSize: AppConstants.normalFontSize,
                minTextFontSize: AppConstants.normalFontSize,
                textAlignment: TextAlign.start,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
