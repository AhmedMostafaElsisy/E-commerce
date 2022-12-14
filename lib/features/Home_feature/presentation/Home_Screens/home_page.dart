import 'package:captien_omda_customer/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_title_text.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import 'request_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.lightWhiteColor,
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///select destination
                      CommonTitleText(
                        textKey:
                            AppLocalizations.of(context)!.lblSelectDestination,
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
                                horizontal:
                                    getWidgetHeight(AppConstants.pagePadding),
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
                                textKey:
                                    AppLocalizations.of(context)!.lblWhereToGo,
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
                                mainTitle: "لوريم ايبسوم لوريم ايبسوم  ",
                                subTitle: "لوريم ايبسوم لوريم ايبسوم  ",
                                onReorderClick: () {
                                  ///Todo: aad reorder func
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return getSpaceHeight(AppConstants.pagePadding);
                            },
                            itemCount: 10),
                      ),
                    ]),
              ),
            )
          ],
        ));
  }
}
