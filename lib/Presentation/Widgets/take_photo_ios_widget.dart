import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/Constants/app_constants.dart';
import 'common_title_text.dart';

class TakePhotoIos extends StatelessWidget {
  final Function(XFile)? getImageFunction;

  const TakePhotoIos({
    Key? key,
    required this.getImageFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        SizedBox(
          width: 280,
          height: 48,
          child: CupertinoActionSheetAction(
              onPressed: () {
                pickImage(
                    context: context,
                    getImage: getImageFunction,
                    source: ImageSource.camera);
              },
              child: CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblCamera,
                textColor: AppConstants.mainTextColor,
                textFontSize: AppConstants.mediumFontSize,
                textWeight: FontWeight.w400,
              )),
        ),
        SizedBox(
          width: 280,
          height: 48,
          child: CupertinoActionSheetAction(
            onPressed: () {
              pickImage(
                  context: context,
                  getImage: getImageFunction,
                  source: ImageSource.gallery);
            },
            child: CommonTitleText(
              textKey: AppLocalizations.of(context)!.lblGallery,
              textColor: AppConstants.mainTextColor,
              textFontSize: AppConstants.mediumFontSize,
              textWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblCancel,
          textColor: AppConstants.mainTextColor,
          textFontSize: AppConstants.mediumFontSize,
          textWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

pickImage(
    {required context,
    required Function(XFile)? getImage,
    required ImageSource source}) async {
  try {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);
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
