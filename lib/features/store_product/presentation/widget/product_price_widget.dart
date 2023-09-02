import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class ProductPriceWidget extends StatelessWidget {
  final String productPrice;
  final String? oldPrice;

  const ProductPriceWidget(
      {Key? key,
      required this.productPrice,
      this.oldPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SharedText.screenWidth,
      constraints: BoxConstraints(
        minHeight: getWidgetHeight(50),
        minWidth: SharedText.screenWidth,
        maxHeight: getWidgetHeight(80),
        maxWidth: SharedText.screenWidth,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
          color: AppConstants.lightShadowSecColor),
      padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(12), vertical: getWidgetHeight(8)),

      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblPrice,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.smallFontSize,
          textColor: AppConstants.mainTextColor,
        ),
        Row(
          children: [
            if(oldPrice !=null)...[
              CommonTitleText(
                textKey: oldPrice!,
                textWeight: FontWeight.w600,
                textFontSize: AppConstants.normalFontSize,
                textColor: AppConstants.lightOrangeColor,
                textDecoration: TextDecoration.lineThrough,
              ),
              getSpaceWidth(AppConstants.smallPadding),
            ],
            CommonTitleText(
              textKey: "$productPrice ${AppLocalizations.of(context)!.lblEGP}",
              textWeight: FontWeight.w700,
              textFontSize: AppConstants.normalFontSize,
              textColor: AppConstants.mainTextColor,
            ),
          ],
        )
      ]),
    );
  }
}
