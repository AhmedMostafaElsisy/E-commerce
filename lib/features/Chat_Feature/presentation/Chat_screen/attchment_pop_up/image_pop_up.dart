import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_file_image_widget.dart';

Widget imageDialog(context, path, {bool? isFile = false}) {
  log("this image path ${path}- is image from file ${isFile}");
  return Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    insetPadding: const EdgeInsets.symmetric(horizontal: 18),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 16,
              splashRadius: 15,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel_outlined),
              color: AppConstants.lightWhiteColor,
            ),
          ],
        ),
        isFile!
            ? commonFileImageWidget(
                imageString: path,
                height: getWidgetHeight(500),
                width: getWidgetWidth(335.84),
              )
            : SizedBox(
                width: getWidgetWidth(335.84),
                height: getWidgetHeight(500),
                child: commonCachedImageWidget(
                  path,
                  width: getWidgetWidth(335.84),
                  height: getWidgetHeight(500),
                  fit: BoxFit.fill,
                ),
              ),
      ],
    ),
  );
}
