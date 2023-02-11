import 'package:captien_omda_customer/features/plans_feature/domain/model/plans_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/Helpers/shared_texts.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

class PlanShortItemWidget extends StatelessWidget {
  final PlansModel model;
final bool isSelected;
  const PlanShortItemWidget({Key? key, required this.model,required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getWidgetHeight(80),
          width: SharedText.screenWidth,
          decoration: BoxDecoration(
              color: AppConstants.lightWhiteColor,
              borderRadius: BorderRadius.circular(
                  AppConstants.containerOfListTitleBorderRadius),
              boxShadow: [
                BoxShadow(
                    color: AppConstants.lightBlackColor.withOpacity(0.16),
                    offset: const Offset(0, 0),
                    blurRadius: 4)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(AppConstants.pagePadding),
                vertical: getWidgetHeight(AppConstants.pagePadding)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTitleText(
                        textKey: model.name!,
                        textColor: AppConstants.mainColor,
                        textWeight: FontWeight.w700,
                        textFontSize: AppConstants.normalFontSize,
                      ),
                      getSpaceHeight(AppConstants.smallPadding / 2),
                      CommonTitleText(
                        textKey: currencyFormat.format(model.price!) +
                            AppLocalizations.of(context)!.lblEGP,
                        textColor: AppConstants.starRatingColor,
                        textWeight: FontWeight.w700,
                        textFontSize: AppConstants.largeFontSize,
                      ),
                    ],
                  )
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: getWidgetWidth(32),
                      height: getWidgetHeight(32),
                      decoration: BoxDecoration(
                          color: AppConstants.lightOrangColor,
                          borderRadius: BorderRadius.circular(
                              AppConstants.containerOfListTitleBorderRadius)),
                      child:  const RotatedBox(
                        quarterTurns: -1,
                        child: CommonAssetSvgImageWidget(
                          imageString: "back_arrow_icon.svg",
                          height: 40,
                          width: 40,
                          imageColor: AppConstants.lightOrangeColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        if(isSelected)
        Positioned(
          left: getWidgetWidth(20),
          child: const CommonAssetSvgImageWidget(
            imageString: "selected.svg",
            height: 24,
            width: 24,

          ),
        ),
      ],
    );
  }
}
