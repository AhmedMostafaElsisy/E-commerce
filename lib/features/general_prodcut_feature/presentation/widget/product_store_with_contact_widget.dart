import 'dart:io';

import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../rating_feature/presentation/screen/rating_screen.dart';

class ProductStoreInformationWithRating extends StatelessWidget {
  final ProductModel model;

  const ProductStoreInformationWithRating({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConstants.loaderBackGroundColor,
          borderRadius: BorderRadius.circular(AppConstants.smallRadius)),
      padding: const EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            ///store image
            commonCachedImageWidget(
              model.shopModel!.image!,
              height: 56,
              width: 56,
              isProfile: true,
              isCircular: true,
              radius: 1000,
            ),

            ///Spacer
            getSpaceWidth(AppConstants.smallPadding),

            ///Store name and email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTitleText(
                  textKey: model.shopModel!.name!,
                  textFontSize: AppConstants.smallFontSize,
                  textWeight: FontWeight.w600,
                  textColor: AppConstants.mainColor,
                ),
                getSpaceHeight(AppConstants.smallPadding),
                CommonTitleText(
                  textKey: model.shopModel!.email!,
                  textFontSize: AppConstants.smallFontSize,
                  textWeight: FontWeight.w600,
                  textColor: AppConstants.mainColor,
                ),
              ],
            )
          ],
        ),

        ///product time
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (Platform.isIOS) {
                      await launchUrl(
                        Uri(
                          scheme: "tel",
                          path: model.shopModel!.phone,
                        ),
                      );
                    } else {
                      await launchUrl(Uri(
                        scheme: 'tel',
                        path: model.shopModel!.phone,
                      ));
                    }
                  },
                  child: const CommonAssetSvgImageWidget(
                    imageString: "call.svg",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                    imageColor: AppConstants.mainColor,
                  ),
                ),
                getSpaceWidth(16),
                InkWell(
                  onTap: () {
                    //todo: integrate chat here
                  },
                  child: const CommonAssetSvgImageWidget(
                    imageString: "chat.svg",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                    imageColor: AppConstants.mainColor,
                  ),
                ),
              ],
            ),

            ///spacer
            getSpaceHeight(AppConstants.smallPadding),

            ///store location
            Container(
              width: getWidgetWidth(80),
              height: getWidgetHeight(32),
              decoration: BoxDecoration(
                color: AppConstants.lightOpacityRedColor,
                borderRadius: BorderRadius.circular(AppConstants.smallRadius),
              ),
              child: InkWell(
                onTap: () {
                  showReportSheet(
                      context: context,
                      storeId: model.id!);
                },
                child: Center(
                  child: CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblAddRate,
                    textFontSize: AppConstants.xxSmallFontSize + 2,
                    textColor: AppConstants.lightRedColor,
                    textWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
