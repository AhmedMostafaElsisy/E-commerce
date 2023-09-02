import 'package:flutter/material.dart';

import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';

class ProductDetailsSpacer extends StatelessWidget {
  final double? spaceValue;
  const ProductDetailsSpacer({Key? key,
  this.spaceValue=AppConstants.pagePadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( children: [
      getSpaceHeight(spaceValue!),
      const Divider(
        height: 1,
        color: AppConstants.greyColor,
      ),
      getSpaceHeight(spaceValue!),
    ],);
  }
}
