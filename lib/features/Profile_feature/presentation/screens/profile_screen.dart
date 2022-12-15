import 'package:captien_omda_customer/features/Profile_feature/presentation/screens/profile_data_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/Routes/route_names.dart';
import '../../../../Presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../Presentation/Widgets/common_cached_image_widget.dart';
import '../../../../Presentation/Widgets/common_global_button.dart';
import '../../../../Presentation/Widgets/common_title_text.dart';
import '../../../../Presentation/Widgets/custom_alert_dialog.dart';
import '../../../../Presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/Constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import '../../../Auth_feature/Presentation/logic/Login_Cubit/login_states.dart';
import 'common_pop_up_content.dart';
import 'common_profile_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (profileCtx, profileState) {
          if (profileState is UserLoginErrorState) {
            showSnackBar(
              context: profileCtx,
              title: profileState.error!.errorMassage!,
            );
          } else if (profileState is UserLogoutSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.loginHomePageRoute, (route) => false);
            // BlocProvider.of<BottomNavCubit>(context).selectItem(0);
          }
        },
        builder: (profileCtx, profileState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///profile background
              Container(
                width: getWidgetWidth(550),
                height: getWidgetHeight(190),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight:
                          Radius.circular(AppConstants.bottomSheetBorderRadius),
                      bottomLeft: Radius.circular(
                          AppConstants.bottomSheetBorderRadius)),
                ),
                child: Stack(children: [
                  ///profile background
                  Container(
                    color: AppConstants.mainColor,
                    width: SharedText.screenWidth,
                    height: (140),
                  ),

                  ///back arrow
                  Positioned(
                      top: getWidgetHeight(50),
                      left: getWidgetWidth(16),
                      child: CommonProfileHeaderWidget(
                        imagePath: "back_arrow_icon.svg",
                        imageHeight: 20,
                        imageWidth: 20,
                        imageColor: AppConstants.lightBlackColor,
                        onClick: () {
                          Navigator.pop(context);
                        },
                      )),

                  ///log out function
                  Positioned(
                      top: getWidgetHeight(50),
                      right: getWidgetWidth(16),
                      child: CommonProfileHeaderWidget(
                        imagePath: "logout_icon.svg",
                        imageHeight: 24,
                        imageWidth: 24,
                        imageColor: AppConstants.mainColor,
                        onClick: () {
                          showAlertDialog(context, [
                            CommonPopUpContent(
                              title: AppLocalizations.of(context)!.lblLogOut,
                              subTitle:
                                  AppLocalizations.of(context)!.lblIsLogOut,
                              onSubmitClick: () {
                                Navigator.of(context).pop();
                                profileCtx.read<LoginCubit>().logOut();
                              },
                            ),
                          ]);
                        },
                      )),

                  ///Spacer
                  getSpaceHeight(20),

                  /// user image
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: getWidgetHeight(125),
                                height: getWidgetHeight(125),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppConstants.lightWhiteColor,
                                      width: 5),
                                ),

                                ///user profile image
                                child: commonCachedImageWidget(
                                    context, SharedText.currentUser!.image!,
                                    height: (98),
                                    width: (98),
                                    radius: 1000,
                                    isCircular: true,
                                    isProfile: true),
                              ),
                            ),
                          ]),
                        ]),
                  ),
                ]),
              ),

              ///spacer
              getSpaceHeight(AppConstants.smallPadding),

              ///rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const commonAssetSvgImageWidget(
                    imageString: "rate_star.svg",
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  getSpaceWidth(8),
                  CommonTitleText(
                    textKey: SharedText.currentUser!.rate!,
                    textFontSize: AppConstants.smallFontSize,
                    textColor: AppConstants.lightBlackColor,
                    textWeight: FontWeight.w700,
                  ),
                ],
              ),
              getSpaceHeight(25),
              ProfileDataItem(
                image: "person_icon.svg",
                title: AppLocalizations.of(context)!.lblName,
                data: SharedText.currentUser!.name!,
              ),

              getSpaceHeight(12),
              ProfileDataItem(
                image: "phone_icon.svg",
                title: AppLocalizations.of(context)!.lblPhone,
                data: SharedText.currentUser!.phone!,
              ),
              getSpaceHeight(12),
              ProfileDataItem(
                image: "email_icon.svg",
                title: AppLocalizations.of(context)!.lblEmail,
                data: SharedText.currentUser!.email!,
                isLastItem: true,
              ),
              getSpaceHeight(120),

              ///Edit profile
              CommonGlobalButton(
                buttonText: AppLocalizations.of(context)!.lblEdit,
                onPressedFunction: () {
                  ///Todo: edit profile screen route
                  // Navigator.pushNamed(
                  //     context, RouteNames.editProfilePageRoute);
                },
                height: 48,
                elevation: 0,
                showBorder: true,
                borderColor: AppConstants.mainColor,
                buttonBackgroundColor: AppConstants.lightWhiteColor,
                buttonTextSize: AppConstants.smallFontSize,
                buttonTextFontWeight: FontWeight.w700,
                buttonTextColor: AppConstants.mainColor,
              ),

              ///Spacer
              getSpaceHeight(AppConstants.pagePadding),

              ///Change password
              CommonGlobalButton(
                  buttonText: AppLocalizations.of(context)!.lblChangePassWord,
                  onPressedFunction: () {
                    ///Todo: add change password screen route
                  },
                  height: 48,
                  elevation: 0,
                  showBorder: false,
                  buttonBackgroundColor: AppConstants.lightSecondShadowColor,
                  buttonTextSize: AppConstants.largeFontSize,
                  buttonTextFontWeight: FontWeight.w700,
                  buttonTextColor: AppConstants.mainColor,
                  withIcon: false),

              ///Spacer
              getSpaceHeight(AppConstants.pagePadding),

              ///Delete account
              CommonGlobalButton(
                  buttonText: AppLocalizations.of(context)!.lblDeleteAccount,
                  onPressedFunction: () {
                    showAlertDialog(context, [
                      CommonPopUpContent(
                        title: AppLocalizations.of(context)!.lblDeleteAccount,
                        subTitle:
                        AppLocalizations.of(context)!.lblDeleteThisAccount,
                        onSubmitClick: () {
                          Navigator.of(context).pop();
                          profileCtx.read<LoginCubit>().deleteAccount();
                        },
                      ),
                    ]);
                  },
                  height: 48,
                  elevation: 0,
                  showBorder: false,
                  isLoading: profileState is UserDeleteAccountLoadingState,
                  buttonBackgroundColor: AppConstants.lightSecondShadowColor,
                  buttonTextSize: AppConstants.largeFontSize,
                  buttonTextFontWeight: FontWeight.w700,
                  buttonTextColor: AppConstants.mainColor,
                  withIcon: false),
            ],
          );
        },
      ),
    );
  }
}
