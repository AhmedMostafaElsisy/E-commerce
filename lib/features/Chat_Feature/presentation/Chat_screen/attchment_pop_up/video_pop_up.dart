import 'dart:developer';

import 'package:flutter/material.dart';

import '../widget/video_item.dart';

Widget videoDialog(context, path, {bool? isFile = false}) {
  log("this video path ${path} - is image from file ${isFile}");
  return Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    insetPadding: const EdgeInsets.symmetric(horizontal: 18),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VideoPostItem(
          canPlay: true,
          videoUrl: path,
          playerHeight: 600,
          isLocal: isFile!,
        ),
      ],
    ),
  );
}
