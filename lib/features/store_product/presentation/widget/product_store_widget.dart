import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class ProductStoreInformation extends StatelessWidget {
  final ProductModel model;

  const ProductStoreInformation({Key? key, required this.model})
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonAssetSvgImageWidget(
                  imageString: "time.svg",
                  height: 16,
                  width: 16,
                  fit: BoxFit.contain,
                  imageColor: AppConstants.mainColor,
                ),
                getSpaceWidth(4),
                CommonTitleText(
                  textKey: model.time!,
                  textFontSize: AppConstants.xxSmallFontSize + 2,
                  textColor: AppConstants.mainColor,
                  textWeight: FontWeight.w600,
                ),
              ],
            ),

            ///spacer
            getSpaceHeight(AppConstants.smallPadding),

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
                  textKey: "${model.shopModel!.location}   ,",
                  textFontSize: AppConstants.xxSmallFontSize + 2,
                  textColor: AppConstants.mainColor,
                  textWeight: FontWeight.w600,
                ),
                getSpaceWidth(8),
                CommonTitleText(
                  textKey: "${model.shopModel!.city}",
                  textFontSize: AppConstants.xxSmallFontSize + 2,
                  textColor: AppConstants.mainColor,
                  textWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
