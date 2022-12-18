import 'package:flutter/material.dart';

import '../../core/Constants/app_constants.dart';
import '../../core/Helpers/shared.dart';


Future<void> showAlertDialog(
    BuildContext context, List<Widget> children) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.smallRadius),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            width: getWidgetWidth(300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      });
}
