import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';

import 'package:flutter/material.dart';

void showBottomModalSheet(
    {required BuildContext context,
    required double height,
    required List<Widget> children,
    TextStyle? textStyle,
    Color bgColor = Colors.white}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(AppConstants.bottomSheetBorderRadius),
      topRight: Radius.circular(AppConstants.bottomSheetBorderRadius),
    )),
    builder: (builder) {
      return Container(
        height: getWidgetHeight(height),
        padding: const EdgeInsets.symmetric(vertical: AppConstants.pagePadding),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstants.bottomSheetBorderRadius),
            topRight: Radius.circular(AppConstants.bottomSheetBorderRadius),
          ),
        ),
        child: Column(
          children: children,
        ),
      );
    },
  );
}
