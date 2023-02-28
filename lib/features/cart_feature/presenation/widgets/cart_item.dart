import 'package:captien_omda_customer/core/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SharedText.screenWidth,
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 4,
                color: AppConstants.lightBlackColor.withOpacity(0.16))
          ]),
      padding: EdgeInsets.all(getWidgetHeight(8)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonTitleText(
              textKey: "#${cartItem.quantity}",
              textColor: AppConstants.mainTextColor,
              textFontSize: 14,
              textWeight: FontWeight.w600,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(AppConstants.smallPadding),
                  horizontal: getWidgetWidth(AppConstants.smallPadding)),
              decoration: BoxDecoration(
                  color: AppConstants.lightGreenColor,
                  borderRadius:
                      BorderRadius.circular(AppConstants.smallRadius)),
              child: Center(
                child: CommonTitleText(
                  textKey: cartItem.productModel.name!,
                  textColor: AppConstants.greenColor,
                  textFontSize: 10,
                  textWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        getSpaceHeight(AppConstants.smallPadding),
        const Divider(
          height: 1,
          color: AppConstants.greyColor,
        ),
        getSpaceHeight(AppConstants.smallPadding),
        Row(
          children: [
            CommonTitleText(
              textKey: "${AppLocalizations.of(context)!.lblTotal}:",
              textColor: AppConstants.mainTextColor,
              textFontSize: 14,
              textWeight: FontWeight.w600,
            ),
            getSpaceWidth(2),
            CommonTitleText(
              textKey:
                  "${cartItem.total} ${AppLocalizations.of(context)!.lblEGP}",
              textWeight: FontWeight.w700,
              textFontSize: AppConstants.smallFontSize,
              textColor: AppConstants.lightOrangeColor,
            ),
          ],
        ),
      ]),
    );
  }
}
