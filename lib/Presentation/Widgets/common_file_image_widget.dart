import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/Helpers/shared.dart';

Widget commonFileImageWidget({
  required String imageString,
  required double height,
  required double width,
  double radius = 0.0,
  BoxFit? fit = BoxFit.contain,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: Image.file(
      File(imageString),
      fit: fit,
      height: getWidgetHeight(height),
      width: getWidgetHeight(height),
    ),
  );
}
