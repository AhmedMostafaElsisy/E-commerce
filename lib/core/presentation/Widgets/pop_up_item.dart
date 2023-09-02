import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import 'common_title_text.dart';

class PopUpItemWidget extends StatelessWidget {
  final String name;
  final bool isSelected;
  const PopUpItemWidget(
      {Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isSelected ? 1 : 0),
          width: getWidgetWidth(16),
          height: getWidgetHeight(16),
          decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppConstants.mainColor : Colors.transparent,
              ),
              shape: BoxShape.circle),
          child: Container(
            decoration: BoxDecoration(
                color: isSelected ? AppConstants.mainColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppConstants.mainColor)),
          ),
        ),

        /// Spacer
        getSpaceWidth(4),

        Expanded(
          child: CommonTitleText(
            textAlignment: TextAlign.start,
            lines: 2,
            textOverflow: TextOverflow.ellipsis,
            textKey: name,
            textWeight: FontWeight.w400,
            textFontSize: AppConstants.xSmallFontSize,
            minTextFontSize: AppConstants.xSmallFontSize,
            textColor: AppConstants.mainTextColor,
          ),
        ),
      ],
    );
  }
}
