import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/custom_flutter_toast.dart';

onWillPop(BuildContext context) async {
  DateTime now = DateTime.now();
  if (SharedText.currentBackPressTime == null ||
      now.difference(SharedText.currentBackPressTime!) >
          const Duration(seconds: 2)) {
    SharedText.currentBackPressTime = now;

    showFlutterToast(
        message: 'Tap again to leave',
        bgColor: AppConstants.borderInputColor,
        textColor: AppConstants.lightBlackColor);

    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}
