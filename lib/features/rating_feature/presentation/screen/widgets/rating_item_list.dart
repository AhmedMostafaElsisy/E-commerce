import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../../core/presentation/Widgets/star_builder_widget.dart';
import '../../../Domain/model/store_rating_model.dart';
import 'package:flutter/material.dart';

class RatingItemList extends StatelessWidget {
  final StoreRatingModel model;

  const RatingItemList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SharedText.screenWidth,
      margin: const EdgeInsets.all(1),
      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(AppConstants.smallPadding),
          horizontal: getWidgetWidth(AppConstants.smallPadding)),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            commonCachedImageWidget(
              model.userModel!.image ?? "",
              height: 48,
              width: 48,
              isProfile: true,
              isCircular: true,
              radius: 1000,
            ),
            getSpaceWidth(AppConstants.smallPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTitleText(
                  textKey:
                      "${model.userModel!.name ?? ""}\n ${AppLocalizations.of(context)!.lblAddRateON} ${model.shopModel!.name!}",
                  textFontSize: AppConstants.normalFontSize,
                  textWeight: FontWeight.w600,
                  textColor: AppConstants.lightBlackColor,
                  lines: 3,
                  textAlignment: TextAlign.start,
                ),
                getSpaceHeight(AppConstants.smallPadding / 2),
                StarRating(
                    color: AppConstants.starRatingColor,
                    rating: double.parse(model.rate.toString())),
              ],
            ),
          ],
        ),
        getSpaceHeight(AppConstants.smallPadding),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.smallPadding)),
          child: CommonTitleText(
            textKey: model.comment!,
            textFontSize: AppConstants.smallFontSize,
            minTextFontSize: AppConstants.smallFontSize,
            textWeight: FontWeight.w500,
            textColor: AppConstants.borderInputColor,
            textAlignment: TextAlign.start,
            lines: 8,
          ),
        ),
      ]),
    );
  }
}
