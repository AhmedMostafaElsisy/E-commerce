import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';

import '../../Helpers/shared.dart';

void showSnackBar(
    {required BuildContext context, required String title, Color? color}) {
  Color backgroundColor = color ?? AppConstants.lightRedColor;

  final snackBar = SnackBar(
    content: CommonTitleText(
      textKey: title,
      textColor: AppConstants.lightWhiteColor,
      textWeight: FontWeight.w700,
      textFontSize: AppConstants.smallFontSize,
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 150,
      right: getWidgetWidth(16),
      left: getWidgetWidth(16),
    ),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
