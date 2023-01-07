import 'package:captien_omda_customer/core/model/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/star_builder_widget.dart';

class StoreInfoCard extends StatelessWidget {
  final ShopModel shopModel;

  const StoreInfoCard({Key? key, required this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///card info
        Container(
          decoration: BoxDecoration(
              color: AppConstants.loaderBackGroundColor,
              borderRadius: BorderRadius.circular(AppConstants.smallRadius)),
          padding: const EdgeInsets.all(8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                ///store image
                commonCachedImageWidget(
                  shopModel.image!,
                  height: 56,
                  width: 56,
                  isProfile: true,
                  isCircular: true,
                  radius: 1000,
                ),

                ///Spacer
                getSpaceWidth(AppConstants.smallPadding),

                ///Store name and rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTitleText(
                      textKey: shopModel.name!,
                      textFontSize: AppConstants.smallFontSize,
                      textWeight: FontWeight.w700,
                      textColor: AppConstants.mainColor,
                    ),
                    getSpaceHeight(AppConstants.smallPadding / 2),
                    StarRating(
                      color: AppConstants.starRatingColor,
                      rating: double.parse(shopModel.rate.toString()),
                    ),
                  ],
                )
              ],
            ),

            ///store main category ,location
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///store main category
                Row(
                  children: [
                    CommonTitleText(
                      textKey: shopModel.category!,
                      textFontSize: AppConstants.xxSmallFontSize + 2,
                      textWeight: FontWeight.w600,
                      textColor: AppConstants.mainColor,
                    ),

                    ///spacer
                    getSpaceWidth(4),

                    ///Divider
                    Container(
                      width: getWidgetWidth(1),
                      height: getWidgetHeight(16),
                      color: AppConstants.lightGrayColor,
                    ),

                    ///Spacer
                    getSpaceWidth(4),

                    ///sub category
                    CommonTitleText(
                      textKey: shopModel.subCategory!.split(" ").first,
                      textFontSize: AppConstants.xxSmallFontSize + 2,
                      textWeight: FontWeight.w600,
                      textColor: AppConstants.mainColor,
                    ),
                  ],
                ),

                ///spacer
                getSpaceHeight(AppConstants.smallPadding / 2),

                ///store location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CommonAssetSvgImageWidget(
                      imageString: "location.svg",
                      height: 16,
                      width: 16,
                      fit: BoxFit.contain,
                      imageColor: AppConstants.mainColor,
                    ),
                    getSpaceWidth(4),
                    CommonTitleText(
                      textKey: "${shopModel.location}   ,",
                      textFontSize: AppConstants.xxSmallFontSize + 2,
                      textColor: AppConstants.mainColor,
                      textWeight: FontWeight.w600,
                    ),
                    getSpaceWidth(8),
                    CommonTitleText(
                      textKey: "${shopModel.city}",
                      textFontSize: AppConstants.xxSmallFontSize + 2,
                      textColor: AppConstants.mainColor,
                      textWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),

        ///spacer
        getSpaceHeight(AppConstants.smallPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///Store notification
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: getWidgetHeight(4)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.smallRadius),
                    color: AppConstants.lightGreenColor),
                child: Column(
                  children: [
                    const CommonAssetSvgImageWidget(
                        imageString: "store_cart.svg", height: 16, width: 16),
                    getSpaceHeight(AppConstants.smallPadding),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblStoreOrder,
                      textWeight: FontWeight.w600,
                      textFontSize: AppConstants.smallFontSize - 2,
                      textColor: AppConstants.greenColor,
                    )
                  ],
                ),
              ),
            ),

            ///Spacer
            getSpaceWidth(AppConstants.smallPadding),

            ///store chat
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: getWidgetHeight(4)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.smallRadius),
                    color: AppConstants.lightShadowSecColor),
                child: Column(
                  children: [
                    const CommonAssetSvgImageWidget(
                        imageString: "chat.svg", height: 16, width: 16),
                    getSpaceHeight(AppConstants.smallPadding),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblStoreOrder,
                      textWeight: FontWeight.w600,
                      textFontSize: AppConstants.smallFontSize - 2,
                      textColor: AppConstants.mainTextColor,
                    )
                  ],
                ),
              ),
            ),
            getSpaceWidth(AppConstants.smallPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: getWidgetHeight(4)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.smallRadius),
                    color: AppConstants.lightOrangColor),
                child: Column(
                  children: [
                    const CommonAssetSvgImageWidget(
                        imageString: "store_notification.svg",
                        height: 16,
                        width: 16),
                    getSpaceHeight(AppConstants.smallPadding),
                    CommonTitleText(
                      textKey:
                          AppLocalizations.of(context)!.lblStoreNotification,
                      textWeight: FontWeight.w600,
                      textFontSize: AppConstants.smallFontSize - 2,
                      textColor: AppConstants.lightOrangeColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
