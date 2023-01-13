import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:captien_omda_customer/features/Setting_feature/presentation/setting_widget/section_content_item.dart';
import 'package:captien_omda_customer/features/Setting_feature/presentation/setting_widget/setting_section.dart';
import 'package:captien_omda_customer/features/Setting_feature/presentation/setting_widget/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../../core/presentation/Routes/route_names.dart';
import '../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../core/presentation/Widgets/custom_alert_dialog.dart';
import '../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../core/presentation/screen/main_app_page.dart';
import '../../Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import '../../Auth_feature/Presentation/logic/Login_Cubit/login_states.dart';
import '../../Profile_feature/presentation/screens/common_pop_up_content.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainAppPage(
          screenContent: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(AppConstants.pagePadding)),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSpaceHeight(50),

                    ///Setting title
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblSetting,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.normalFontSize,
                      textColor: AppConstants.mainTextColor,
                    ),

                    ///Spacer
                    getSpaceHeight(20),
                    if (SharedText.currentUser != null) ...[
                      ///User profile card
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.editProfilePageRoute);
                          },
                          child: const UserProfileCard()),

                      ///Spacer
                      getSpaceHeight(4),
                    ],

                    ///my account
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblAccount,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.normalFontSize,
                      textColor: AppConstants.mainTextColor,
                    ),

                    ///Spacer
                    getSpaceHeight(4),

                    ///account section
                    SettingSection(
                      sectionContent: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 11),
                        child: Column(children: [
                          ///my order
                          SectionContentItem(
                            title: AppLocalizations.of(context)!.lblOrders,
                            screenName: RouteNames.myOrderPageRoute,
                          ),

                          ///favorite
                          SectionContentItem(
                            title: AppLocalizations.of(context)!.lbFavorite,
                            screenName: RouteNames.favoritePageRoute,
                          ),

                          ///my stores
                          SectionContentItem(
                            title: AppLocalizations.of(context)!.lblMyShop,
                            screenName: RouteNames.myStoresPageRoute,
                          ),
                          SectionContentItem(
                            title: AppLocalizations.of(context)!
                                .lblCustomerRequests,
                          ),
                          SectionContentItem(
                            title: AppLocalizations.of(context)!.lblRatings,
                          ),
                          SectionContentItem(
                            title: AppLocalizations.of(context)!.lblMassage,
                            isLastItem: true,
                          ),
                        ]),
                      ),
                    ),

                    ///Spacer
                    getSpaceHeight(6),

                    ///App setting
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblAppSetting,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.normalFontSize,
                      textColor: AppConstants.mainTextColor,
                    ),

                    ///Spacer
                    getSpaceHeight(6),

                    ///App setting section
                    SettingSection(
                      sectionContent: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 11),
                        child: Column(children: [
                          ///Change password
                          SectionContentItem(
                            title:
                                AppLocalizations.of(context)!.lblChangePassWord,
                            screenName: RouteNames.changePasswordPageRoute,
                          ),

                          ///notification
                          SectionContentItem(
                            title:
                                AppLocalizations.of(context)!.lblNotification,
                          ),

                          ///Call support
                          SectionContentItem(
                            title: AppLocalizations.of(context)!.lblCallSupport,
                          ),

                          ///terms and conditions
                          SectionContentItem(
                            title: AppLocalizations.of(context)!
                                .lblOutTermsAndConditions,
                            isLastItem: true,
                          ),
                        ]),
                      ),
                    ),

                    ///Spacer
                    getSpaceHeight(6),

                    ///Log out
                    BlocConsumer<LoginCubit, LoginStates>(
                        listener: (profileCtx, profileState) {
                      if (profileState is UserLoginErrorState) {
                        showSnackBar(
                          context: profileCtx,
                          title: profileState.error!.errorMassage!,
                        );
                      } else if (profileState is UserLogoutSuccessState) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteNames.loginHomePageRoute, (route) => false);
                        // BlocProvider.of<BottomNavCubit>(context).selectItem(0);
                      }
                    }, builder: (profileCtx, profileState) {
                      return InkWell(
                        onTap: () {
                          if (profileState is! UserLoginLoadingState) {
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
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:AppConstants.lightContentColor,
                            borderRadius: BorderRadius.circular(AppConstants.smallRadius)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8),
                            child: Row(children: [
                              const CommonAssetSvgImageWidget(
                                imageString: "logout_icon.svg",
                                height: 16,
                                width: 16,
                                imageColor: AppConstants.lightWhiteColor,
                              ),
                              getSpaceWidth(4),
                              CommonTitleText(
                                textKey:
                                    AppLocalizations.of(context)!.lblLogOut,
                                textWeight: FontWeight.w600,
                                textFontSize: AppConstants.smallFontSize,
                                textColor: AppConstants.lightWhiteColor,
                              ),
                            ]),
                          ),
                        ),
                      );
                    })
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
