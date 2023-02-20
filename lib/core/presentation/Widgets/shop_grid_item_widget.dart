import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import '../../model/shop_model.dart';

class ShopGridItemWidget extends StatelessWidget {
  final ShopModel model;

  const ShopGridItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: getWidgetWidth(168),
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
          boxShadow: [
            BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.16),
                offset: const Offset(0, 0),
                blurRadius: 4)
          ]),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ///shop image
        commonCachedImageWidget(model.image!,
            height: 150, width: 168, fit: BoxFit.fill),

        ///spacer
        getSpaceHeight(8),

        ///shop name
        CommonTitleText(
          textKey: model.name!,
          textFontSize: AppConstants.smallFontSize,
          textColor: AppConstants.mainTextColor,
          textWeight: FontWeight.w600,
        ),

        ///Spacer
        getSpaceHeight(8),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///shop category
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CommonAssetSvgImageWidget(
                      imageString: "category.svg",
                      height: 16,
                      width: 16,
                      fit: BoxFit.contain,
                      imageColor: AppConstants.mainColor,
                    ),
                    getSpaceWidth(4),
                    Expanded(
                      child: CommonTitleText(
                        textKey: model.category!.name,
                        textFontSize: AppConstants.xxSmallFontSize,
                        textColor: AppConstants.lightContentColor,
                        textWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              ///shop location
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4,
                  ),
                  child: Row(
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
                      Expanded(
                        child: CommonTitleText(
                          textKey: model.address ?? "asda",
                          textFontSize: AppConstants.xxSmallFontSize,
                          textColor: AppConstants.lightContentColor,
                          textWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
