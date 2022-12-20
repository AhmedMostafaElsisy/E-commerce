import 'dart:io';

import 'package:captien_omda_customer/features/trip_feature/presentation/trip_location_item.dart';
import 'package:captien_omda_customer/features/trip_feature/presentation/trip_states_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/Constants/Enums/request_states.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../../core/presentation/Routes/route_names.dart';
import '../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../core/presentation/Widgets/common_global_button.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import '../../../core/presentation/Widgets/custom_alert_dialog.dart';
import '../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../core/setting_feature/Logic/setting_cubit.dart';
import '../../Profile_feature/presentation/screens/common_pop_up_content.dart';
import '../logic/trip_cubit/trip_cubit.dart';
import '../logic/trip_cubit/trip_cubit_states.dart';
import 'package:url_launcher/url_launcher.dart';

import 'driveri_data_widget.dart';

class CurrentTripDetailsScreen extends StatefulWidget {
  const CurrentTripDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CurrentTripDetailsScreen> createState() =>
      _CurrentTripDetailsScreenState();
}

class _CurrentTripDetailsScreenState extends State<CurrentTripDetailsScreen> {
  late bool canClick;

  @override
  void initState() {
    super.initState();
    canClick = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        withNotification: false,
        showBottomIcon: false,
        withBack: true,
        showLeadingWidget: true,
        customActionWidget: InkWell(
          onTap: () {
            showAlertDialog(context, [
              CommonPopUpContent(
                title: AppLocalizations.of(context)!.lblCallSupport,
                subTitle: AppLocalizations.of(context)!.lbCallSupportDesc,
                onSubmitClick: !canClick
                    ? () {}
                    : () async {
                        if (canClick) {
                          setState(() {
                            canClick = false;
                          });
                          if (Platform.isIOS) {
                            await launch(
                                "tel://${BlocProvider.of<SettingCubit>(context).settingModel.sitePhone!}");
                            await Future.delayed(
                              const Duration(seconds: 5),
                            );
                          } else {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: BlocProvider.of<SettingCubit>(context)
                                  .settingModel
                                  .sitePhone!,
                            );
                            Navigator.of(context).pop();
                            await launchUrl(launchUri);
                            await Future.delayed(const Duration(seconds: 5));
                          }
                          setState(() {
                            canClick = true;
                          });
                        }
                      },
              ),
            ]);
          },
          child: const CommonAssetSvgImageWidget(
              imageString: "call_support.svg",
              isCircular: true,
              height: 32,
              width: 32,
              radius: 1000,
              fit: BoxFit.contain),
        ),
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblCurrentRequest,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: BlocConsumer<TripCubit, TripCubitState>(
        listener: (tripCtx, tripState) {
          if (tripState is ChangeStatesTripSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.mainBottomNavPageRoute,
              (route) => false,
            );
          } else if (tripState is CurrentTripFailedState) {
            checkUserAuth(context: tripCtx, errorType: tripState.error.type);
            showSnackBar(
              context: tripCtx,
              title: tripState.error.errorMassage!,
            );
          } else if (tripState is RequestDetailsSuccessState) {
            if (tripCtx.read<TripCubit>().requestModel.state ==
                RequestStates.finishedRequest) {
              ///TODO: navigate to rate request
            }
          }
        },
        builder: (tripCtx, tripState) {
          return Column(children: [
            ///Spacer
            getSpaceHeight(20),

            ///car image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    tripCtx.read<TripCubit>().getRequestDetails(
                        requestId: tripCtx.read<TripCubit>().requestModel.id!);
                  },
                  child: CommonAssetSvgImageWidget(
                    imageString: "trip_car.svg",
                    height: 205,
                    width: SharedText.screenWidth,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

            ///Spacer
            getSpaceHeight(25),
            Container(
              width: SharedText.screenWidth,
              height: getWidgetHeight(478),
              decoration: BoxDecoration(
                  color: AppConstants.lightWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        color: AppConstants.lightBlackColor.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: const Offset(0, 1))
                  ],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppConstants.borderRadius),
                    topLeft: Radius.circular(AppConstants.borderRadius),
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidgetHeight(AppConstants.pagePadding),
                    vertical: getWidgetWidth(AppConstants.pagePadding)),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///select destination
                      CommonTitleText(
                        textKey:
                            AppLocalizations.of(context)!.lblRequestDetails,
                        textColor: AppConstants.lightBlackColor,
                        textWeight: FontWeight.w700,
                        textFontSize: AppConstants.smallFontSize,
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.pagePadding),

                      ///Searching for a car
                      if (tripCtx.read<TripCubit>().requestModel.state ==
                          RequestStates.newRequest) ...[
                        const TripStatesWidget(),
                      ] else ...[
                        DriverDataWidget(
                          model: tripCtx.read<TripCubit>().requestModel,
                        ),
                      ],

                      ///spacer
                      getSpaceHeight(AppConstants.pagePadding),

                      ///spacer
                      const Divider(
                        color: AppConstants.lightGrayColor,
                        thickness: 1,
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.pagePadding),
                      TripLocationItem(
                        currentLocation: tripCtx
                            .read<TripCubit>()
                            .requestModel
                            .fromLocation!
                            .locationName!,
                        destinationLocation: tripCtx
                            .read<TripCubit>()
                            .requestModel
                            .toLocation!
                            .locationName!,
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.pagePaddingDouble),

                      ///trip price
                      Container(
                        height: getWidgetHeight(48),
                        width: SharedText.screenWidth,
                        decoration: BoxDecoration(
                          color: AppConstants.lightGreyTextColor,
                          borderRadius: BorderRadius.circular(
                              AppConstants.containerBorderRadius),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CommonAssetSvgImageWidget(
                                imageString: "cash_icon.svg",
                                height: 25,
                                width: 25,
                                fit: BoxFit.contain,
                                imageColor: AppConstants.lightBorderColor,
                              ),
                              getSpaceWidth(AppConstants.smallPadding / 2),
                              CommonTitleText(
                                textKey:
                                    "${tripCtx.read<TripCubit>().requestModel.price!} ${AppLocalizations.of(context)!.lblEGP}",
                                textColor: AppConstants.lightBorderColor,
                                textWeight: FontWeight.w700,
                                textFontSize: AppConstants.normalFontSize,
                              ),
                            ]),
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.pagePadding),
                      if (tripCtx.read<TripCubit>().requestModel.state !=
                          RequestStates.startedRequest)
                        CommonGlobalButton(
                          height: 48,
                          buttonBackgroundColor: AppConstants.lightWhiteColor,
                          buttonTextColor: AppConstants.mainColor,
                          borderColor: AppConstants.mainColor,
                          showBorder: true,
                          isLoading: tripState is ChangeStatesTripLoadingState,
                          buttonTextSize: AppConstants.normalFontSize,
                          buttonTextFontWeight: FontWeight.w700,
                          buttonText: AppLocalizations.of(context)!.lblCancel,
                          onPressedFunction: () {
                            showAlertDialog(context, [
                              CommonPopUpContent(
                                title:
                                    AppLocalizations.of(context)!.lblCancelTile,
                                subTitle:
                                    AppLocalizations.of(context)!.lblCancelDesc,
                                onSubmitClick: () {
                                  Navigator.of(context).pop();
                                  tripCtx.read<TripCubit>().changeRequestSates(
                                      states: "Canceled",
                                      requestId: tripCtx
                                          .read<TripCubit>()
                                          .requestModel
                                          .id!);
                                },
                              ),
                            ]);
                          },
                        ),

                      ///spacer
                      getSpaceHeight(AppConstants.pagePadding),
                    ],
                  ),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
