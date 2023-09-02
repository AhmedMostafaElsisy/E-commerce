import 'package:flutter/material.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../Helpers/shared_texts.dart';
import '../../../presentation/Widgets/common_title_text.dart';

class PopUpMultiItem extends StatelessWidget {
  final String name;
  final bool isSelected;

  const PopUpMultiItem({Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(47),
      width: SharedText.screenWidth,
      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(13),
          horizontal: getWidgetWidth(AppConstants.pagePadding)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CommonTitleText(
          textKey: name,
          textWeight: FontWeight.w600,
          textColor: AppConstants.lightBlackColor,
          textFontSize: AppConstants.mediumFontSize,
        ),
        if (isSelected)
          const Icon(
            Icons.check,
            color: AppConstants.lightBlackColor,
            size: 20,
          )
      ]),
    );
  }
}
