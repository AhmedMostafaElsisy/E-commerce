import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class CommonWrapItem extends StatelessWidget {
  final Function(dynamic) onTap;
  final dynamic model;
  final bool isSelected;

  const CommonWrapItem({
    Key? key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(model);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: getWidgetHeight(4),
          horizontal: getWidgetWidth(4),
        ),
        padding: EdgeInsets.symmetric(
            vertical: getWidgetHeight(8), horizontal: getWidgetWidth(12)),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected
                  ? AppConstants.mainColor
                  : AppConstants.lightContentColor),
          borderRadius: BorderRadius.circular(25),
          color: isSelected
              ? AppConstants.mainColor
              : AppConstants.lightWhiteColor,
        ),
        child: CommonTitleText(
          textKey: model.name,
          textColor: isSelected
              ? AppConstants.lightWhiteColor
              : AppConstants.lightContentColor,
          textWeight: FontWeight.w600,
          textFontSize: AppConstants.xSmallFontSize,
        ),
      ),
    );
  }
}
