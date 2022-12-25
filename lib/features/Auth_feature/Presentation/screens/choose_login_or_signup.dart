import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';

class ChooseLoginSignupScreen extends StatefulWidget {
  const ChooseLoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseLoginSignupScreenState();
}

class _ChooseLoginSignupScreenState extends State<ChooseLoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: Container(
          width: SharedText.screenWidth,
          height: SharedText.screenHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/backGround.png",
                  ),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(AppConstants.pagePadding)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonAssetImageWidget(
                  imageString: "splash_logo.png",
                  height: 160,
                  width: 125,
                ),
                getSpaceHeight(48),

                /// Login
                CommonGlobalButton(
                  buttonTextFontWeight: FontWeight.w600,
                  buttonTextSize: AppConstants.largeFontSize,
                  showBorder: true,
                  elevation: 0,
                  buttonText: AppLocalizations.of(context)!.lblLogin,
                  onPressedFunction: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.loginHomePageRoute);
                  },
                  height: 56,
                  radius: AppConstants.smallRadius,
                ),

                /// Space
                getSpaceHeight(AppConstants.pagePadding),

                /// Sign Up
                CommonGlobalButton(
                  buttonTextFontWeight: FontWeight.w600,
                  buttonTextSize: AppConstants.largeFontSize,
                  showBorder: false,
                  elevation: 0,
                  buttonText: AppLocalizations.of(context)!.lblSignup,
                  onPressedFunction: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.singUpPageRoute);
                  },
                  height: 56,
                  buttonBackgroundColor: AppConstants.loaderBackGroundColor,
                  buttonTextColor: AppConstants.mainColor,
                  radius: AppConstants.smallRadius,
                ),

                /// Space
                getSpaceHeight(AppConstants.pagePaddingDouble * 2),

                ///login with social accounts
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: getWidgetWidth(41),
                      height: getWidgetHeight(4),
                      decoration: BoxDecoration(
                          color: AppConstants.mainColor,
                          borderRadius: BorderRadius.circular(
                              AppConstants.smallRadius + 2)),
                    ),
                    getSpaceWidth(2),
                    Expanded(
                      child: CommonTitleText(
                        textKey: AppLocalizations.of(context)!
                            .lblLoginWithSocialMedia,
                        textWeight: FontWeight.w600,
                        textColor: AppConstants.mainTextColor,
                        textFontSize: AppConstants.smallFontSize,
                        minTextFontSize: AppConstants.xSmallFontSize,
                      ),
                    ),
                    getSpaceWidth(2),
                    Container(
                      width: getWidgetWidth(41),
                      height: getWidgetHeight(4),
                      decoration: BoxDecoration(
                          color: AppConstants.mainColor,
                          borderRadius: BorderRadius.circular(
                              AppConstants.smallRadius + 2)),
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
                          ///Todo:add facebook integration
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
                          ///Todo:add google integration
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
            ),
          ),
        ),
      ),
    );
  }
}
