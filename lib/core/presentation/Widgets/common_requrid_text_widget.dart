import 'package:flutter/material.dart';
import '../../Constants/app_constants.dart';
import 'common_title_text.dart';

class CommonRequiredText extends StatelessWidget {
  final String textKey;
  final Color textColor;

  final FontWeight textWeight;

  final double textFontSize;
  final double minTextFontSize;

  final TextAlign textAlignment;

  final int lines;
  final TextOverflow textOverflow;
  final TextDecoration? textDecoration;
  final bool? isRequired;

  const CommonRequiredText(
      {Key? key,
      required this.textKey,
      this.textColor = AppConstants.lightBlackColor,
      this.textWeight = FontWeight.normal,
      this.textFontSize = AppConstants.normalFontSize,
      this.minTextFontSize = 9,
      this.textAlignment = TextAlign.center,
      this.lines = 1,
      this.textOverflow = TextOverflow.visible,
      this.isRequired = true,
      this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTitleText(
          textKey: textKey,
          textColor: textColor,
          textWeight: textWeight,
          textFontSize: textFontSize,
          lines: lines,
          textAlignment: textAlignment,
          minTextFontSize: minTextFontSize,
          textOverflow: textOverflow,
          textDecoration: textDecoration,
        ),
        if(isRequired!)
        CommonTitleText(
          textKey: " *",
          textWeight: textWeight,
          textColor: textColor,
          textFontSize: textFontSize,
        ),
      ],
    );
  }
}
