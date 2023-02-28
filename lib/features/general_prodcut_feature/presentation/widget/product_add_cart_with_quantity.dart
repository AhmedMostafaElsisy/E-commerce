import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class AddProductToCartWithQuantity extends StatelessWidget {
  final ProductModel product;

  const AddProductToCartWithQuantity({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getWidgetHeight(40),
          decoration: BoxDecoration(
            color: AppConstants.lightOrangColor,
            borderRadius: BorderRadius.circular(
              AppConstants.smallRadius,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: getWidgetWidth(24),
                child: const CommonTitleText(
                  textKey: "+",
                  textFontSize: AppConstants.mediumFontSize,
                ),
              ),
              SizedBox(
                width: getWidgetWidth(24),
                child: const CommonTitleText(
                  textKey: "1",
                ),
              ),
              SizedBox(
                width: getWidgetWidth(24),
                child: const CommonTitleText(
                  textKey: "-",
                  textFontSize: AppConstants.mediumFontSize,
                ),
              ),
            ],
          ),
        ),
        getSpaceWidth(4),
        CommonGlobalButton(
          width: 120,
          withIcon: true,
          iconPath: "shop_cart.svg",
          iconWidth: 16,
          iconHeight: 16,
          iconColor: AppConstants.lightWhiteColor,
          buttonText: AppLocalizations.of(context)!.addToCart,
          onPressedFunction: () {},
        ),
      ],
    );
  }
}
