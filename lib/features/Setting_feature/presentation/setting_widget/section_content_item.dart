import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

class SectionContentItem extends StatelessWidget {
  final String title;
  final Widget? actionWidget;
  final bool? isLastItem;

  const SectionContentItem(
      {Key? key,
      required this.title,
      this.isLastItem = false,
      this.actionWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSpaceHeight(2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///my account
            CommonTitleText(
              textKey: title,
              textWeight: FontWeight.w500,
              textFontSize: AppConstants.normalFontSize,
              textColor: AppConstants.mainColor,
            ),
            actionWidget ??
                const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppConstants.mainColor,
                  size: 22,
                ),
          ],
        ),
        if (!isLastItem!)...[
          getSpaceHeight(4),
          const Divider(
            color: AppConstants.greyColor,
            thickness: 0.2,
          )
        ]
      ],
    );
  }
}
