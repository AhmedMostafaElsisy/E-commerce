import 'package:flutter/material.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

class ChatTimeAndSeenWidget extends StatelessWidget {
  final bool isMe;
  final bool isSeen;
  final String dateOfCreation;

  const ChatTimeAndSeenWidget(
      {Key? key,
      required this.isMe,
      required this.isSeen,
      required this.dateOfCreation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("is seen $isSeen");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isMe) ...[
          Icon(
            isSeen ? Icons.done_all : Icons.check,
            size: 14,
            color: isSeen
                ? AppConstants.fetchReadedCheckColor(isMe)
                : AppConstants.fetchUnReadCheckColor(isMe),
          ),
          getSpaceWidth(8),
          CommonTitleText(
            textKey: dateOfCreation,
            textColor: isMe
                ? AppConstants.lightBlackColor
                : AppConstants.lightBlackColor,
            textFontSize: AppConstants.xxSmallFontSize,
            minTextFontSize: AppConstants.xxSmallFontSize,
            textWeight: FontWeight.w500,
            lines: 50,
            textAlignment: isMe ? TextAlign.start : TextAlign.end,
          ),
        ] else ...[
          CommonTitleText(
            textKey: dateOfCreation,
            textColor: isMe
                ? AppConstants.lightBlackColor
                : AppConstants.lightBlackColor,
            textFontSize: AppConstants.xxSmallFontSize,
            minTextFontSize: AppConstants.xxSmallFontSize,
            textWeight: FontWeight.w500,
            lines: 50,
            textAlignment: isMe ? TextAlign.start : TextAlign.end,
          ),
          getSpaceWidth(8),
          SizedBox(
            width: getWidgetWidth(16),
          ),
        ]
      ],
    );
  }
}
