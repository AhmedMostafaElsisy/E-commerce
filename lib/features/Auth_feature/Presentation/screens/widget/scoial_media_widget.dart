import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

class SocialMediaWidget extends StatelessWidget {
  final String title;
  final Function() onGoogleClicked;
  final Function() onFacebookClicked;

  const SocialMediaWidget(
      {Key? key,
      required this.title,
      required this.onFacebookClicked,
      required this.onGoogleClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///login with social accounts
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getWidgetWidth(41),
              height: getWidgetHeight(4),
              decoration: BoxDecoration(
                  color: AppConstants.mainColor,
                  borderRadius:
                      BorderRadius.circular(AppConstants.smallRadius + 2)),
            ),
            getSpaceWidth(2),
            Expanded(
              child: CommonTitleText(
                textKey: title,
                textWeight: FontWeight.w600,
                textColor: AppConstants.mainTextColor,
                textFontSize: AppConstants.smallFontSize,
              ),
            ),
            getSpaceWidth(2),
            Container(
              width: getWidgetWidth(41),
              height: getWidgetHeight(4),
              decoration: BoxDecoration(
                  color: AppConstants.mainColor,
                  borderRadius:
                      BorderRadius.circular(AppConstants.smallRadius + 2)),
            ),
          ],
        ),

        /// Space
        getSpaceHeight(AppConstants.pagePadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///login with faceBook
            Expanded(
              child: CommonGlobalButton(
                showBorder: true,
                borderColor: AppConstants.mainColor,
                buttonTextFontWeight: FontWeight.w600,
                buttonTextSize: AppConstants.normalFontSize,
                elevation: 0,
                buttonBackgroundColor: AppConstants.lightWhiteColor,
                buttonTextColor: AppConstants.mainColor,
                buttonText: AppLocalizations.of(context)!.lblFaceBook,
                onPressedFunction: () {
                  onFacebookClicked();
                },
                height: 48,
                radius: AppConstants.containerBorderRadius,
                withIcon: true,
                iconPath: "facebook_logo.svg",
                iconWidth: getWidgetWidth(24),
                iconHeight: getWidgetHeight(24),
                spaceSize: 10,
              ),
            ),

            ///Spacer
            getSpaceWidth(8),

            /// login with google
            Expanded(
              child: CommonGlobalButton(
                showBorder: true,
                borderColor: AppConstants.mainColor,
                buttonTextFontWeight: FontWeight.w600,
                buttonTextSize: AppConstants.normalFontSize,
                elevation: 0,
                buttonBackgroundColor: AppConstants.lightWhiteColor,
                buttonTextColor: AppConstants.mainColor,
                buttonText: AppLocalizations.of(context)!.lblGoogle,
                onPressedFunction: () {
                  onGoogleClicked();
                },
                height: 48,
                radius: AppConstants.containerBorderRadius,
                withIcon: true,
                iconPath: "google_logo.svg",
                iconWidth: getWidgetWidth(24),
                iconHeight: getWidgetHeight(24),
                spaceSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
