import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/Constants/app_constants.dart';

class CommonTitleText extends StatelessWidget {
  final String textKey;
  final Color textColor;

  final FontWeight textWeight;

  final double textFontSize;
  final double minTextFontSize;

  final TextAlign textAlignment;

  final int lines;
  final TextOverflow textOverflow;
  final bool? isUnderLine;

  const CommonTitleText(
      {Key? key,
      required this.textKey,
      this.textColor = AppConstants.lightBlackColor,
      this.textWeight = FontWeight.normal,
      this.textFontSize = AppConstants.normalFontSize,
      this.minTextFontSize = 9,
      this.textAlignment = TextAlign.center,
      this.lines = 1,
      this.textOverflow = TextOverflow.visible,
      this.isUnderLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      textKey,
      overflow: TextOverflow.ellipsis,
      minFontSize: minTextFontSize,
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: textColor,
            fontSize: textFontSize,
            fontWeight: textWeight,
            overflow: textOverflow,
            decoration: isUnderLine! ? TextDecoration.underline:null,
          ),
      textAlign: textAlignment,
      maxLines: lines,
    );
  }
}
