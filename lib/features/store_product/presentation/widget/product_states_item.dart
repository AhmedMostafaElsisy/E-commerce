import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class ProductStatesItem extends StatelessWidget {
  final String title;
  final String value;

  const ProductStatesItem({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonTitleText(
          textKey: title,
          textWeight: FontWeight.w500,
          textFontSize: AppConstants.smallFontSize,
          textColor: AppConstants.mainTextColor,
        ),

        ///Spacer
        getSpaceHeight(AppConstants.smallPadding),
        CommonTitleText(
          textKey: value,
          textWeight: FontWeight.w500,
          textFontSize: AppConstants.xSmallFontSize,
          textColor: AppConstants.lightOrangeColor,
        ),
      ],
    );
  }
}
