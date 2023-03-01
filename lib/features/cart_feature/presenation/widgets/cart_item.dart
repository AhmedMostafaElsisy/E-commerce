import 'package:captien_omda_customer/core/model/cart_model.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonCachedImageWidget(
              cartItem.productModel.images?.first.imageUrl ?? "",
              height: 90,
              width: 90),
          getSpaceWidth(AppConstants.smallPadding),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getSpaceHeight(AppConstants.smallPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTitleText(
                      textKey: cartItem.productModel.name ?? "",
                      textColor: AppConstants.mainTextColor,
                      textFontSize: 14,
                      textWeight: FontWeight.w600,
                    ),
                  ],
                ),
                getSpaceHeight(AppConstants.smallPadding),
                const Divider(
                  height: 2,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
