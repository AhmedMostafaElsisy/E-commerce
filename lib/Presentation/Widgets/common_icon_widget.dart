import 'package:default_repo_app/Constants/Enums/device_enums.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';


InkWell commonIcon(
    IconData iconData,
    Color color,
    double mobileSize, {
      final Function()? onTapIcon,
    }) =>
    InkWell(
      onTap: onTapIcon,
      child: Icon(iconData, color: color, size: mobileSize),
    );
