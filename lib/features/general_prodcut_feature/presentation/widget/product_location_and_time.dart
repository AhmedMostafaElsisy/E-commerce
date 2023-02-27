import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/model/product_model.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class ProductLocationAndTime extends StatelessWidget {
  final ProductModel product;

  const ProductLocationAndTime({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
              textKey: "${product.shopModel!.city!.name!}   ,",
              textFontSize: AppConstants.xxSmallFontSize + 2,
              textColor: AppConstants.mainColor,
              textWeight: FontWeight.w600,
            ),
            getSpaceWidth(8),
            CommonTitleText(
              textKey: product.shopModel!.area!.name!,
              textFontSize: AppConstants.xxSmallFontSize + 2,
              textColor: AppConstants.mainColor,
              textWeight: FontWeight.w600,
            ),
          ],
        ),

        ///spacer
        getSpaceHeight(AppConstants.smallPadding),

        ///product time
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
              textKey: product.time ?? "==",
              textFontSize: AppConstants.xxSmallFontSize + 2,
              textColor: AppConstants.mainColor,
              textWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
