import '../../core/Constants/app_constants.dart';
import 'package:default_repo_app/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/Helpers/shared.dart';


Widget takePhotoDialog(
    {context,
    Function(XFile)? getImageFunction,}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    insetPadding: const EdgeInsets.symmetric(horizontal: 18),
    child: Container(
      height: getWidgetHeight(150),
      width: getWidgetWidth(250),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppConstants.containerBorderRadius,
          ),
          color: AppConstants.lightWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblTakePhoto,
            textFontSize: 16,
            textColor: AppConstants.mainTextColor,
            textWeight: FontWeight.w500,
          ),
          getSpaceHeight(30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              onTap:(){
                pickImage(
                    context: context,

                    getImage: getImageFunction,
                    source: ImageSource.camera);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera,
                    size: 22,
                    color: AppConstants.mainColor,
                  ),
                  getSpaceHeight(8),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblCamera,
                    textFontSize: 14,
                    textWeight: FontWeight.w400,
                    textColor: AppConstants.mainTextColor,
                  )
                ],
              ),
            ),
            getSpaceWidth(22),
            InkWell(
              onTap:(){
                pickImage(
                    context: context,

                    getImage: getImageFunction,
                    source: ImageSource.gallery);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 22,
                    color: AppConstants.mainColor,
                  ),
                  getSpaceHeight(8),
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblGallery,
                    textFontSize: 14,
                    textWeight: FontWeight.w400,
                    textColor: AppConstants.mainTextColor,
                  ),
                ],
              ),
            )
          ]),
          getSpaceWidth(10),
        ],
      ),
    ),
  );
}

pickImage(
    {required context,required Function(XFile)? getImage, required ImageSource source}) async {
  try {
    final ImagePicker _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) {

    } else {
      getImage!(pickedFile);
      Navigator.of(context).pop();
    }
  } catch (e) {
    Navigator.of(context).pop();

    debugPrint('Error Fetching Image: $e');
  }
}
