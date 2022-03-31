import 'package:default_repo_app/Constants/app_constants.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_flutter_toast.dart';
onWillPop(BuildContext context) async {
  DateTime now = DateTime.now();
  if (SharedText.currentBackPressTime == null ||
      now.difference(SharedText.currentBackPressTime!) >
          const Duration(seconds: 2)) {
    SharedText.currentBackPressTime = now;

    showFlutterToast(
        message: 'Tap again to leave',
        bgColor: AppConstants.greyColor,
        textColor: AppConstants.lightBlackColor);

    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}
