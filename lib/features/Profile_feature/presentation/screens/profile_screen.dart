import 'package:captien_omda_customer/features/Profile_feature/presentation/screens/profile_data_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Logic/Bloc_Cubits/Profile_Cubit/profile_cubit.dart';
import '../../../../Logic/Bloc_Cubits/Profile_Cubit/profile_states.dart';
import '../../../../Presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../Presentation/Widgets/common_cached_image_widget.dart';
import '../../../../Presentation/Widgets/common_global_button.dart';
import '../../../../Presentation/Widgets/common_title_text.dart';
import '../../../../Presentation/Widgets/custom_alert_dialog.dart';
import '../../../../core/Constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
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
      body: BlocConsumer<ProfileCubit, ProfileCubitStates>(
        listener: (profileCtx, profileState) {
          // if (profileState is DeleteAccountStatesError) {
          //   showSnackBar(
          //     context: profileCtx,
          //     title: profileState.error!.errorMassage!,
          //   );
          // } else if (profileState is DeleteAccountStatesSuccess) {
          //   Navigator.pushNamedAndRemoveUntil(
          //       context, RouteNames.loginHomePageRoute, (route) => false);
          //   // BlocProvider.of<BottomNavCubit>(context).selectItem(0);
          // }
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
                          // Navigator.pop(context);
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
                      // Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     CommonTitleText(
                      //       textKey:
                      //           AppLocalizations.of(context)!.lblDeleteAccount,
                      //       textColor: AppConstants.lightBlackColor,
                      //       textFontSize: AppConstants.normalFontSize,
                      //       textWeight: FontWeight.w400,
                      //     ),
                      //     getSpaceHeight(16),
                      //     CommonTitleText(
                      //       textKey: AppLocalizations.of(context)!
                      //           .lblDeleteThisAccount,
                      //       textColor: AppConstants.mainTextColor,
                      //       lines: 3,
                      //       textFontSize: AppConstants.smallFontSize,
                      //       textWeight: FontWeight.w400,
                      //     ),
                      //     getSpaceHeight(16),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         /// Cancel
                      //         CommonGlobalButton(
                      //             showBorder: false,
                      //             width: 80,
                      //             buttonTextFontWeight: FontWeight.w400,
                      //             buttonTextSize: AppConstants.smallFontSize,
                      //             elevation: 0,
                      //             buttonBackgroundColor:
                      //                 AppConstants.mainTextColor,
                      //             buttonText:
                      //                 AppLocalizations.of(context)!.lblCancel,
                      //             onPressedFunction: () {
                      //               Navigator.of(context, rootNavigator: true)
                      //                   .pop();
                      //             },
                      //             height: 36,
                      //             radius: AppConstants.smallRadius,
                      //             withIcon: false),
                      //         getSpaceWidth(16),
                      //
                      //         /// OK
                      //         CommonGlobalButton(
                      //             showBorder: true,
                      //             borderColor: AppConstants.mainColor,
                      //             width: 80,
                      //             buttonTextFontWeight: FontWeight.w400,
                      //             buttonTextSize: AppConstants.smallFontSize,
                      //             elevation: 0,
                      //             buttonBackgroundColor:
                      //                 AppConstants.lightWhiteColor,
                      //             buttonTextColor: AppConstants.mainColor,
                      //             buttonText:
                      //                 AppLocalizations.of(context)!.lblYes,
                      //             onPressedFunction: () {
                      //               // Navigator.of(context, rootNavigator: true)
                      //               //     .pop();
                      //               // profileCtx
                      //               //     .read<ProfileCubit>()
                      //               //     .deleteAccount();
                      //             },
                      //             height: 36,
                      //             radius: AppConstants.smallRadius,
                      //             withIcon: false),
                      //       ],
                      //     )
                      //   ],
                      // )
                    ]);
                  },
                  height: 48,
                  elevation: 0,
                  showBorder: false,
                  // isLoading: profileState is DeleteAccountLoadingState,
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
