import '../../core/Helpers/shared.dart';
import 'package:flutter/material.dart';

showWaitingDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    // barrierColor: Colors.red,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        contentPadding: const EdgeInsets.all(0.0),
        content: Image.asset('assets/images/splash.png',
            fit: BoxFit.contain,
            height: getWidgetHeight(78),
            width: getWidgetWidth(237)),
      );
    },
  );
}
