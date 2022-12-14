import 'package:captien_omda_customer/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_empty_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_title_text.dart';
import 'package:captien_omda_customer/core/Helpers/Extensions/prevent_string_spacing.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/request_cubit/request_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/request_cubit/request_cubit_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../Presentation/Widgets/common_app_bar_widget.dart';
import '../../../../../Presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/Constants/app_constants.dart';
import 'request_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RequestCubit requestCubit;

  @override
  void initState() {
    super.initState();
    requestCubit = BlocProvider.of<RequestCubit>(context);
    requestCubit.getHomeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.lightWhiteColor,
        appBar: CommonAppBar(
          withNotification: true,
          showBottomIcon: false,
          withBack: false,
          showLeadingWidget: true,
          leadingWidget: commonCachedImageWidget(
              context, SharedText.currentUser!.image!,
              isProfile: true,
              isCircular: true,
              height: 30,
              width: 30,
              radius: 1000,
              fit: BoxFit.contain),
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblHello,
                textColor: AppConstants.mainTextColor,
                textWeight: FontWeight.w500,
                textFontSize: AppConstants.smallFontSize,
              ),
              CommonTitleText(
                textKey:
                    SharedText.currentUser!.name!.getStringWithoutSpacings(),
                textColor: AppConstants.mainColor,
                textWeight: FontWeight.w700,
                textFontSize: AppConstants.smallFontSize,
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///Spacer
            getSpaceHeight(50),

            ///car image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                commonAssetSvgImageWidget(
                  imageString: "car_icon.svg",
                  height: 135,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ],
            ),

            ///Spacer
            getSpaceHeight(50),
            Container(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight - getWidgetHeight(388),
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
                child: BlocConsumer<RequestCubit, RequestCubitState>(
                  listener: (requestCtx, requestState) {
                    if (requestState is RequestHomeFailedState) {
                      checkUserAuth(
                          context: requestCtx,
                          errorType: requestState.error.type);
                    }
                  },
                  builder: (requestCtx, requestState) {
                    if (requestState is RequestHomeLoadingState) {
                      return const CommonLoadingWidget();
                    } else if (requestState is RequestHomeEmptyState) {
                      return const EmptyScreen(
                          imageString: "car_icon.svg",
                          titleKey: "no request found ",
                          imageHeight: 50,
                          imageWidth: 50);
                    } else if (requestState is RequestHomeFailedState) {
                      return CommonError(
                        errorMassage: requestState.error.errorMassage,
                        onTap: () {
                          requestCubit.getHomeRequest();
                        },
                        withButton: true,
                      );
                    } else {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///select destination
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblSelectDestination,
                              textColor: AppConstants.lightBlackColor,
                              textWeight: FontWeight.w700,
                              textFontSize: AppConstants.smallFontSize,
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///where to go
                            InkWell(
                              onTap: () {
                                ///Todo: add navigation for place search
                              },
                              child: Container(
                                height: getWidgetHeight(72),
                                width: SharedText.screenWidth,
                                decoration: BoxDecoration(
                                  color: AppConstants.backGroundColor,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.containerBorderRadius),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppConstants.lightBlackColor
                                            .withOpacity(0.2),
                                        blurRadius: 10.0,
                                        offset: const Offset(0, 1))
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getWidgetHeight(
                                          AppConstants.pagePadding),
                                      vertical: getWidgetWidth(
                                          AppConstants.pagePadding + 4)),
                                  child: Row(children: [
                                    const commonAssetSvgImageWidget(
                                      imageString: "location_from_icon.svg",
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.contain,
                                    ),
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblWhereToGo,
                                      textColor: AppConstants.lightBlackColor,
                                      textWeight: FontWeight.w700,
                                      textFontSize: AppConstants.normalFontSize,
                                    ),
                                  ]),
                                ),
                              ),
                            ),

                            ///Spacer
                            getSpaceHeight(AppConstants.pagePaddingDouble),
                            Expanded(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return RequestItemWidget(
                                      mainTitle: requestCtx
                                          .read<RequestCubit>()
                                          .requestList[index]
                                          .fromLocation!
                                          .locationName!,
                                      subTitle: requestCtx
                                          .read<RequestCubit>()
                                          .requestList[index]
                                          .toLocation!
                                          .locationName!,
                                      onReorderClick: () {
                                        ///Todo: aad reorder func
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return getSpaceHeight(
                                        AppConstants.pagePadding);
                                  },
                                  itemCount: requestCtx
                                      .read<RequestCubit>()
                                      .requestList
                                      .length),
                            ),
                          ]);
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }
}
