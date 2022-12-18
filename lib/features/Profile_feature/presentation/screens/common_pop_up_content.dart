import 'package:flutter/material.dart';
import '../../../../Presentation/Widgets/common_global_button.dart';
import '../../../../Presentation/Widgets/common_title_text.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonPopUpContent extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function() onSubmitClick;

  const CommonPopUpContent(
      {Key? key,
      required this.subTitle,
      required this.onSubmitClick,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonTitleText(
          textKey: title,
          textColor: AppConstants.lightBlackColor,
          textFontSize: AppConstants.normalFontSize,
          textWeight: FontWeight.w700,
        ),
        getSpaceHeight(AppConstants.pagePadding),
        CommonTitleText(
          textKey: subTitle,
          textColor: AppConstants.mainTextColor,
          lines: 3,
          textFontSize: AppConstants.smallFontSize,
          textWeight: FontWeight.w700,
        ),
        getSpaceHeight(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Cancel
            CommonGlobalButton(
                showBorder: false,
                width: 120,

                buttonTextFontWeight: FontWeight.w700,
                buttonTextSize: AppConstants.normalFontSize,
                elevation: 0,
                buttonBackgroundColor: AppConstants.mainColor,
                buttonText: AppLocalizations.of(context)!.lblNo,
                onPressedFunction: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                height: 48,
                radius: AppConstants.containerBorderRadius,
                withIcon: false),
            getSpaceWidth(16),

            /// OK
            CommonGlobalButton(
                showBorder: true,
                borderColor: AppConstants.mainColor,
                width: 120,
                buttonTextFontWeight: FontWeight.w700,
                buttonTextSize: AppConstants.normalFontSize,
                elevation: 0,
                buttonBackgroundColor: AppConstants.lightWhiteColor,
                buttonTextColor: AppConstants.mainColor,
                buttonText: AppLocalizations.of(context)!.lblYes,
                onPressedFunction: () {
                  onSubmitClick();
                },
                height: 48,
                radius: AppConstants.containerBorderRadius,
                withIcon: false),
          ],
        )
      ],
    );
  }
}
