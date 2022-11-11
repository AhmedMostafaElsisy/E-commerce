import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';

class CommonTitleText extends StatelessWidget {
  final String textKey;
  final String drName;
  final Color textColor;

  final FontWeight textWeight;

  final double textFontSize;
  final double minTextFontSize;

  final TextAlign textAlignment;

  final int lines;
  final TextOverflow textOverflow;

  const CommonTitleText({
    Key? key,
    required this.textKey,
    this.drName = '',
    this.textColor = AppConstants.lightBlackColor,
    this.textWeight = FontWeight.normal,
    this.textFontSize = AppConstants.normalFontSize,
    this.minTextFontSize = 9,
    this.textAlignment = TextAlign.center,
    this.lines = 1,
    this.textOverflow = TextOverflow.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      textKey + ' ' + drName,
      overflow: TextOverflow.ellipsis,
      minFontSize: minTextFontSize,
      style: Theme.of(context).textTheme.headline4?.copyWith(
        color: textColor,
        fontSize: textFontSize,
        fontWeight: textWeight,
        overflow: textOverflow,
      ),
      textAlign: textAlignment,
      maxLines: lines,
    );
  }
}
