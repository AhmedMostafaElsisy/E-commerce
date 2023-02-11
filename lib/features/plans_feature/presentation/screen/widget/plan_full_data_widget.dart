import 'package:captien_omda_customer/features/plans_feature/domain/model/plans_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/Helpers/shared_texts.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

class PlanFullItemWidget extends StatelessWidget {
  final PlansModel model;
  final bool isSelected;
final Function()onTap;
  const PlanFullItemWidget(
      {Key? key, required this.model, required this.isSelected,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTitleText(
                        textKey: model.name!,
                        textColor: AppConstants.mainColor,
                        textWeight: FontWeight.w700,
                        textFontSize: AppConstants.normalFontSize,
                      ),
                      Container(
                        width: getWidgetWidth(32),
                        height: getWidgetHeight(32),
                        decoration: BoxDecoration(
                            color: AppConstants.lightOrangColor,
                            borderRadius: BorderRadius.circular(
                                AppConstants.containerOfListTitleBorderRadius)),
                        child: const RotatedBox(
                          quarterTurns: 1,
                          child: CommonAssetSvgImageWidget(
                            imageString: "back_arrow_icon.svg",
                            height: 40,
                            width: 40,
                            imageColor: AppConstants.lightOrangeColor,
                          ),
                        ),
                      )
                    ]),
                getSpaceHeight(AppConstants.pagePadding),
                SizedBox(
                  height: getWidgetHeight(
                      (AppConstants.pagePadding + 30) * model.features!.length),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const CommonAssetSvgImageWidget(
                              imageString: "Check_fill.svg",
                              height: 24,
                              width: 24,
                            ),
                            getSpaceWidth(AppConstants.smallPadding/2),
                            CommonTitleText(
                              textKey: model.features![index].features!,
                              textColor: AppConstants.mainTextColor,
                              textFontSize: AppConstants.xSmallFontSize,
                              textWeight: FontWeight.w400,
                              textAlignment: TextAlign.start,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return getSpaceHeight(AppConstants.pagePadding);
                      },
                      itemCount: model.features!.length),
                ),
                getSpaceHeight(AppConstants.pagePadding),
                Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonGlobalButton(
                      height: 40,
                      width: 160,
                      buttonBackgroundColor:
                      AppConstants.mainColor,
                      buttonTextSize:
                      AppConstants.normalFontSize,
                      buttonTextFontWeight:
                      FontWeight.w700,
                      buttonText:
                      AppLocalizations.of(context)!
                          .lblContinueAndPay,
                      onPressedFunction: onTap,
                    ),

                    CommonTitleText(
                      textKey: currencyFormat.format(model.price!) +
                          AppLocalizations.of(context)!.lblEGP,
                      textColor: AppConstants.starRatingColor,
                      textWeight: FontWeight.w700,
                      textFontSize: AppConstants.largeFontSize,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
