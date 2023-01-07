import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/star_builder_widget.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({Key? key}) : super(key: key);

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(70),
      decoration: BoxDecoration(
          color: AppConstants.loaderBackGroundColor,
          borderRadius: BorderRadius.circular(
              AppConstants.containerOfListTitleBorderRadius)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ///User image
          commonCachedImageWidget(
            SharedText.currentUser!.image!,
            height: 48,
            width: 48,
            isProfile: true,
            isCircular: true,
            radius: 1000,
          ),
          getSpaceWidth(AppConstants.smallPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonTitleText(
                    textKey: SharedText.currentUser!.name!,
                    textFontSize: AppConstants.normalFontSize,
                    textWeight: FontWeight.w600,
                    textColor: AppConstants.lightBlackColor,
                  ),
                  getSpaceWidth(AppConstants.smallPadding / 2),
                  StarRating(
                    color: AppConstants.starRatingColor,
                    rating:
                        double.parse(SharedText.currentUser!.rate!.toString()),
                  ),
                ],
              ),
              getSpaceHeight(AppConstants.smallPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  commonAssetImageWidget(
                      imageString: "setting.png",
                      height: 16,
                      width: 16,
                      imageColor: AppConstants.mainColor),
                  getSpaceWidth(4),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblProfileSetting,
                    textWeight: FontWeight.w500,
                    textFontSize: AppConstants.smallFontSize,
                    textColor: AppConstants.mainColor,
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
