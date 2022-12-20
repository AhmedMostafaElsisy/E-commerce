import 'package:captien_omda_customer/core/Helpers/Extensions/prevent_string_spacing.dart';
import 'package:captien_omda_customer/features/trip_feature/logic/trip_cubit/trip_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/Helpers/shared_texts.dart';
import '../../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../../core/presentation/Widgets/custom_alert_dialog.dart';
import '../../../../../core/setting_feature/Logic/setting_cubit.dart';
import '../../../../Profile_feature/presentation/screens/common_pop_up_content.dart';
import '../../../../trip_feature/logic/trip_cubit/trip_cubit_states.dart';
import '../../../../trip_feature/presentation/trip_location_item.dart';
import '../../logic/request_cubit/request_cubit.dart';

class RequestHistoryDetails extends StatefulWidget {
  final RouteArgument routeArgument;
  const RequestHistoryDetails({Key? key,required this.routeArgument}) : super(key: key);

  @override
  State<RequestHistoryDetails> createState() => _RequestHistoryDetailsState();
}

class _RequestHistoryDetailsState extends State<RequestHistoryDetails> {
  late bool canClick;
  late TripCubit requestCubit;

  @override
  void initState() {
    super.initState();
    canClick = true;
    requestCubit = BlocProvider.of<TripCubit>(context);
    requestCubit.getRequestDetails(requestId:widget.routeArgument.requestId! );
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
          textKey: AppLocalizations.of(context)!.lblOldRequest,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: Column(children: [
        ///Spacer
        getSpaceHeight(20),

        ///car image
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonAssetSvgImageWidget(
              imageString: "trip_car.svg",
              height: 205,
              width: SharedText.screenWidth,
              fit: BoxFit.contain,
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
              child: BlocConsumer<TripCubit,TripCubitState>(
                listener: (requestCtx,requestState){
                  if(requestState is RequestDetailsFailedState){
                    checkUserAuth(
                        context: requestCtx,
                        errorType: requestState.error.type);
                  }
                },
                builder:(requestCtx,requestState){
                  if (requestState is RequestDetailsLoadingState) {
                    return const CommonLoadingWidget();
                  } else if (requestState is RequestDetailsFailedState) {
                    return CommonError(
                      errorMassage: requestState.error.errorMassage,
                      onTap: () {
                        requestCtx.read<TripCubit>().getRequestDetails(requestId: widget.routeArgument.requestId!);
                      },
                      withButton: true,
                    );
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///select destination
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!.lblRequestDetails,
                          textColor: AppConstants.lightBlackColor,
                          textWeight: FontWeight.w700,
                          textFontSize: AppConstants.smallFontSize,
                        ),

                        ///spacer
                        getSpaceHeight(AppConstants.pagePadding),

                        ///Searching for a car
                        Container(
                          // height: getWidgetHeight(72),
                          width: SharedText.screenWidth,
                          decoration: BoxDecoration(
                            color: AppConstants.lightGreyTextColor,
                            borderRadius: BorderRadius.circular(
                                AppConstants.containerBorderRadius),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                getWidgetHeight(AppConstants.pagePadding),
                                vertical:
                                getWidgetWidth(AppConstants.pagePadding + 4)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ///driver data
                                  Row(
                                    children: [
                                      commonCachedImageWidget(context, "imageUrl",
                                          height: 48,
                                          width: 48,
                                          isCircular: true,
                                          isProfile: true),
                                      getSpaceWidth(AppConstants.smallPadding),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CommonTitleText(
                                            textKey: "Drivier name"
                                                .getStringWithoutSpacings(),
                                            textFontSize:
                                            AppConstants.smallFontSize,
                                            textColor: AppConstants.lightBlackColor,
                                            textWeight: FontWeight.w600,
                                          ),
                                          getSpaceHeight(
                                              AppConstants.pagePadding - 2),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: const [
                                              CommonTitleText(
                                                textKey: "لانسر شارك (احمر)",
                                                textFontSize:
                                                AppConstants.smallFontSize - 2,
                                                textColor:
                                                AppConstants.mainTextColor,
                                                textWeight: FontWeight.w700,
                                              ),

                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),

                                  ///trip price
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:  [
                                            const  CommonTitleText(
                                              textKey: "4.3",
                                              textFontSize:
                                              AppConstants.smallFontSize - 2,
                                              textColor:
                                              AppConstants.mainTextColor,
                                              textWeight: FontWeight.w500,
                                            ),
                                            getSpaceWidth(4),
                                            const    CommonAssetSvgImageWidget(
                                              imageString: "rate_star.svg",
                                              width: 16,
                                              height: 16,
                                              fit: BoxFit.cover,
                                              imageColor:
                                              AppConstants.mainColor,
                                            ),
                                          ],
                                        ),
                                        getSpaceHeight(
                                            AppConstants.pagePadding - 2),
                                        const    CommonTitleText(
                                          textKey:
                                          "د و ج 189",
                                          textColor: AppConstants.mainTextColor,
                                          textWeight: FontWeight.w700,
                                          textFontSize: AppConstants.smallFontSize-2,
                                        ),
                                      ]),
                                ]),
                          ),
                        ),

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
                          currentLocation:   requestCtx.read<RequestCubit>().requestModel.fromLocation!.locationName!,
                          destinationLocation: requestCtx.read<RequestCubit>().requestModel.toLocation!.locationName!,
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
                                  "${requestCtx.read<RequestCubit>().requestModel.price} ${AppLocalizations.of(context)!.lblEGP}",
                                  textColor: AppConstants.lightBorderColor,
                                  textWeight: FontWeight.w700,
                                  textFontSize: AppConstants.normalFontSize,
                                ),
                              ]),
                        ),

                        ///spacer
                        getSpaceHeight(AppConstants.pagePadding),

                        ///add rating
                        CommonGlobalButton(
                          height: 48,
                          buttonBackgroundColor: AppConstants.lightWhiteColor,
                          buttonTextColor: AppConstants.mainColor,
                          borderColor: AppConstants.mainColor,
                          showBorder: true,
                          buttonTextSize: AppConstants.normalFontSize,
                          buttonTextFontWeight: FontWeight.w700,
                          buttonText: AppLocalizations.of(context)!.lblAddRating,
                          onPressedFunction: () {
                            ///Todo: navigate to add rating screen
                          },
                        ),

                        ///spacer
                        getSpaceHeight(AppConstants.pagePadding),
                      ]);
                },

              ),
            ),
          ),
        )
      ]),
    );
  }
}
