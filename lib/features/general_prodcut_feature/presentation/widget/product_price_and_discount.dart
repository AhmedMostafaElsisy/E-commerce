import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/model/product_model.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class ProductPriceAndDiscountWidget extends StatelessWidget {
  final ProductModel product;

  const ProductPriceAndDiscountWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CommonTitleText(
              textKey: "${product.price!} ",
              textColor: AppConstants.mainColor,
              textWeight: FontWeight.bold,
              textFontSize: AppConstants.normalFontSize,
            ),
            CommonTitleText(
              textKey: AppLocalizations.of(context)!.lblEGP,
              textColor: AppConstants.mainColor,
              textWeight: FontWeight.bold,
              textFontSize: AppConstants.normalFontSize,
            ),
          ],
        ),
        if (product.discount != null || product.discount!.isNotEmpty) ...[
          Row(
            children: [
              CommonTitleText(
                textKey: "${product.discount!} ",
                textColor: AppConstants.mainColor,
                textWeight: FontWeight.bold,
                textFontSize: AppConstants.normalFontSize,
              ),
              CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblEGP,
                textColor: AppConstants.mainColor,
                textWeight: FontWeight.bold,
                textFontSize: AppConstants.normalFontSize,
              ),
            ],
          ),
        ]
      ],
    );
  }
}
