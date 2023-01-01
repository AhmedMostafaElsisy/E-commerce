import 'package:captien_omda_customer/features/Auth_feature/Presentation/screens/widget/scoial_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/screen/main_app_page.dart';

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
      body: MainAppPage(
        screenContent: Padding(
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
              ),

              /// Space
              getSpaceHeight(AppConstants.pagePaddingDouble * 2),
              SocialMediaWidget(
                title: AppLocalizations.of(context)!.lblLoginWithSocialMedia,
                onFacebookClicked: () {
                  ///Todo:add facebook integration
                },
                onGoogleClicked: () {
                  ///Todo:add google integration
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
