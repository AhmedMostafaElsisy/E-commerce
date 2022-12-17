import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';

import 'common_asset_svg_image_widget.dart';
import 'common_title_text.dart';

void takePhotoBottomSheet({
  context,
  Function(XFile)? getPhoto,
}) {
  showModalBottomSheet(
      backgroundColor: AppConstants.transparentColor,
      barrierColor: AppConstants.lightBlackColor.withOpacity(.34),
      context: context,
      builder: (_) => Container(
        width: double.infinity,
        height: getWidgetHeight(160),
        decoration: const BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppConstants.pagePadding-1),
              topLeft: Radius.circular(AppConstants.pagePadding-1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSpaceHeight(12),
            Center(
              child: Container(
                width: getWidgetWidth(65),
                height: getWidgetHeight(4),
                color: AppConstants.lightBlackColor,
              ),
            ),
            getSpaceHeight(20),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                //   Navigator.of(context).pop();
                pickImage(context: context, getImage: getPhoto, source: ImageSource.camera);
                Navigator.of(_).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getSpaceWidth(18),
                   const CommonAssetSvgImageWidget(imageString: 'camera.svg', height: 18, width: 20),
                  getSpaceWidth(10),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblCamera,
                    textFontSize: AppConstants.largeFontSize,
                  )
                ],
              ),
            ),
            getSpaceHeight(15),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                pickImage(context: context, getImage: getPhoto, source: ImageSource.gallery);
                Navigator.of(_).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getSpaceWidth(18),
                   const CommonAssetSvgImageWidget(imageString: 'gallery.svg', height: 18, width: 20),
                  getSpaceWidth(10),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblGallery,
                    textFontSize: AppConstants.largeFontSize,
                  )
                ],
              ),
            ),
          ],
        ),
      ));
}

pickImage({required context, required Function(XFile)? getImage, required ImageSource source}) async {
  try {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) {
    } else {
      getImage!(pickedFile);
    }
  } catch (e) {

    debugPrint('Error Fetching Image: $e');
  }
}
