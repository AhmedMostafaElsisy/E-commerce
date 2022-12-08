import '../../../core/Constants/app_constants.dart';
import 'package:captien_omda_customer/Presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../Widgets/common_asset_svg_image_widget.dart';

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
        child: SizedBox(
          width: SharedText.screenWidth,
          height: SharedText.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              commonAssetSvgImageWidget(
                imageString: "splash_logo.svg",
                height: 200,
                  width: 200
              ),
              getSpaceHeight(56),

              /// Login
              CommonGlobalButton(
                  buttonTextFontWeight: FontWeight.w400,
                  buttonTextSize: AppConstants.largeFontSize,
                  showBorder: true,
                  elevation: 0,
                  buttonText: AppLocalizations.of(context)!.lblLogin,
                  onPressedFunction: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.loginHomePageRoute);
                  },
                  height: 56,
                  // width: getWidgetWidth(),
                  radius: AppConstants.smallRadius,
                  withIcon: false),

              /// Space
              getSpaceHeight(24),

              /// Sign Up
              CommonGlobalButton(
                  buttonTextFontWeight: FontWeight.w400,
                  buttonTextSize: AppConstants.largeFontSize,
                  showBorder: false,
                  elevation: 0,
                  buttonText: AppLocalizations.of(context)!.lblSignup,
                  onPressedFunction: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.singUpPageRoute);
                  },
                  height: 56,
                  buttonBackgroundColor: AppConstants.lightSecondShadowColor,
                  // width: getWidgetWidth(),
                  buttonTextColor: AppConstants.mainColor,
                  radius: AppConstants.smallRadius,
                  withIcon: false)
            ],
          ),
        ),
      ),
    );
  }
}
