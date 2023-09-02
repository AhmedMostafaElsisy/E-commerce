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
