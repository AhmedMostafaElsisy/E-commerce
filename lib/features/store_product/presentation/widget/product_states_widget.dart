import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_states_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductInformationWidget extends StatelessWidget {
  final ProductModel model;
  const ProductInformationWidget({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SharedText.screenWidth,
      constraints: BoxConstraints(
        minHeight: getWidgetHeight(60),
        minWidth: SharedText.screenWidth,
        maxHeight: getWidgetHeight(80),
        maxWidth: SharedText.screenWidth,
      ),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(AppConstants.smallRadius),
          color: AppConstants.lightOrangColor),
      padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(12),
          vertical: getWidgetHeight(10)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///Product type
            ProductStatesItem(
              title: AppLocalizations.of(context)!.lblAdsType,
              value:model.type! ,
            ),
            Container(
              width: getWidgetWidth(1),
              height: getWidgetHeight(40),
              color: AppConstants.starRatingColor,
            ),
            ///Product States
            ProductStatesItem(
              title: AppLocalizations.of(context)!.lblStates,
              value:model.state! ,
            ),
            Container(
              width: getWidgetWidth(1),
              height: getWidgetHeight(40),
              color: AppConstants.starRatingColor,
            ),
            ///Product states
            ProductStatesItem(
              title: AppLocalizations.of(context)!.lblBrand,
              value:model.shopModel!.category!.name ,
            ),

          ]),
    );
  }
}
