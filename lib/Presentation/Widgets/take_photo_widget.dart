import 'dart:io';

import 'package:default_repo_app/Presentation/Widgets/take_photo_android_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/take_photo_ios_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future selectedPhoto(context,
    {required Function(XFile) takePhoto,
    }) async {
  ///select photo for ios
  if (Platform.isIOS) {
    return showCupertinoModalPopup(
        context: context,
        builder: (_) => TakePhotoIos(
              getImageFunction: takePhoto,
            ));
  } else {
    ///show dialog if platForm android
    return await showDialog(
      context: context,
      builder: (_) => takePhotoDialog(
        context: context,
        getImageFunction: takePhoto,
      ),
    );
  }
}
