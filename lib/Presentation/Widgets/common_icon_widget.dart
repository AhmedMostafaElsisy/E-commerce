import 'package:default_repo_app/Constants/Enums/device_enums.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';

Icon commonIcon(
    IconData iconData, Color color, double mobileSize, double tabletSize) =>
    Icon(iconData,
        color: color,
        size: SharedText.deviceType!.deviceType == DeviceType.mobile
            ? mobileSize
            : tabletSize);