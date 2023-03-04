import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../../core/presentation/Routes/route_argument_model.dart';
import '../../../core/presentation/Widgets/common_cached_image_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final RouteArgument argument;

  const OrderDetailsScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainAppPage(
          screenContent: Stack(
            children: [
              Column(
                children: [
                  CommonAppBar(
                    withBack: true,
                    appBarBackGroundColor: AppConstants.transparent,
                    showBottomIcon: false,
                    centerTitle: false,
                    titleWidget: CommonTitleText(
                      textKey: "#${widget.argument.orderModel!.id!}",
                      textColor: AppConstants.lightBlackColor,
                      textWeight: FontWeight.w400,
                      textFontSize: AppConstants.normalFontSize,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                                horizontal:
                                    getWidgetWidth(AppConstants.pagePadding),
                                vertical: getWidgetHeight(
                                    AppConstants.smallPadding)) +
                            EdgeInsets.only(bottom: getWidgetHeight(75)),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            width: SharedText.screenWidth,
                            decoration: BoxDecoration(
                                color: AppConstants.lightWhiteColor,
                                borderRadius: BorderRadius.circular(
                                    AppConstants.smallRadius),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 4,
                                      color: AppConstants.lightBlackColor
                                          .withOpacity(0.16))
                                ]),
                            child: Row(
                              children: [
                                commonCachedImageWidget(
                                    widget
                                            .argument
                                            .orderModel!
                                            .orderCart![index]
                                            .productModel
                                            .images!
                                            .first
                                            .imageUrl ??
                                        "",
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.fill),
                                getSpaceWidth(AppConstants.smallPadding),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTitleText(
                                      textKey: widget.argument.orderModel!
                                          .orderCart![index].productModel.name!,
                                      textWeight: FontWeight.w600,
                                      textFontSize: AppConstants.smallFontSize,
                                      textColor: AppConstants.mainTextColor,
                                    ),
                                    getSpaceHeight(AppConstants.pagePadding),
                                    Container(
                                      width: SharedText.screenWidth -
                                          getWidgetWidth(150),
                                      height: getWidgetHeight(1),
                                      color: AppConstants.greyColor,
                                    ),
                                    getSpaceHeight(AppConstants.pagePadding),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CommonTitleText(
                                                textKey: AppLocalizations.of(
                                                        context)!
                                                    .lblQty,
                                                textWeight: FontWeight.w700,
                                                textFontSize:
                                                    AppConstants.smallFontSize,
                                                textColor:
                                                    AppConstants.mainTextColor,
                                              ),
                                              getSpaceWidth(4),
                                              CommonTitleText(
                                                textKey: widget
                                                    .argument
                                                    .orderModel!
                                                    .orderCart![index]
                                                    .quantity
                                                    .toString(),
                                                textWeight: FontWeight.w600,
                                                textFontSize:
                                                    AppConstants.normalFontSize,
                                                textColor:
                                                    AppConstants.mainColor,
                                              ),
                                            ],
                                          ),
                                          getSpaceWidth(110),
                                          CommonTitleText(
                                            textKey:
                                                "${widget.argument.orderModel!.orderCart![index].total.toString()} ${AppLocalizations.of(context)!.lblEGP}",
                                            textWeight: FontWeight.w600,
                                            textFontSize:
                                                AppConstants.normalFontSize,
                                            textColor:
                                                AppConstants.lightOrangeColor,
                                            textAlignment: TextAlign.end,
                                          ),
                                        ]),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return getSpaceHeight(AppConstants.pagePadding);
                        },
                        itemCount:
                            widget.argument.orderModel!.orderCart!.length),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: SharedText.screenWidth,
                    height: getWidgetHeight(70),
                    decoration: BoxDecoration(
                        color: AppConstants.lightWhiteColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                              AppConstants.containerOfListTitleBorderRadius),
                          topRight: Radius.circular(
                              AppConstants.containerOfListTitleBorderRadius),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: AppConstants.lightBlackColor
                                  .withOpacity(0.16),
                              offset: const Offset(0, 0),
                              blurRadius: 4)
                        ]),
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.pagePadding),
                        vertical: getWidgetHeight(AppConstants.pagePadding)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTitleText(
                            textKey:
                                AppLocalizations.of(context)!.lblTotalPrice,
                            textWeight: FontWeight.w700,
                            textFontSize: AppConstants.smallFontSize,
                            textColor: AppConstants.mainTextColor,
                          ),
                          CommonTitleText(
                            textKey:
                                "${widget.argument.orderModel!.total!.toString()} ${AppLocalizations.of(context)!.lblEGP}",
                            textWeight: FontWeight.w600,
                            textFontSize: AppConstants.normalFontSize,
                            textColor: AppConstants.lightOrangeColor,
                            textAlignment: TextAlign.end,
                          ),
                        ]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
