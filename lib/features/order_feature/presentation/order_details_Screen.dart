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
          screenContent: Column(
            children: [
              const CommonAppBar(
                withBack: true,
                appBarBackGroundColor: AppConstants.transparent,
                showBottomIcon: false,
                centerTitle: false,
                titleWidget: CommonTitleText(
                  textKey: "#1225",
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),

              ///search
              SizedBox(
                width: getWidgetWidth(343),
                height: getWidgetHeight(36),
                child: Row(
                  children: const [
                    CommonTitleText(
                      textKey: "احمد الدالي",
                      textWeight: FontWeight.w700,
                      textFontSize: AppConstants.normalFontSize,
                      textColor: AppConstants.mainTextColor,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.pagePadding),
                        vertical: getWidgetHeight(AppConstants.smallPadding)),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: SharedText.screenWidth,
                        decoration: BoxDecoration(
                            color: AppConstants.lightWhiteColor,
                            borderRadius:
                                BorderRadius.circular(AppConstants.smallRadius),
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
                                "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
                                height: 90,
                                width: 90,
                                fit: BoxFit.fill),
                            getSpaceWidth(AppConstants.smallPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CommonTitleText(
                                  textKey: "منتج تجريبي اساسي",
                                  textWeight: FontWeight.w600,
                                  textFontSize: AppConstants.smallFontSize,
                                  textColor: AppConstants.mainTextColor,
                                ),
                                getSpaceHeight(AppConstants.pagePadding),
                                Container(
                                  width: SharedText.screenWidth-getWidgetWidth(150),
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
                                            textKey: AppLocalizations.of(context)!
                                                .lblQty,
                                            textWeight: FontWeight.w700,
                                            textFontSize:
                                                AppConstants.smallFontSize,
                                            textColor: AppConstants.mainTextColor,
                                          ),
                                          const CommonTitleText(
                                            textKey: " 01",
                                            textWeight: FontWeight.w600,
                                            textFontSize:
                                            AppConstants.normalFontSize,
                                            textColor: AppConstants.mainColor,
                                          ),
                                        ],
                                      ),
                                      getSpaceWidth(110),
                                      CommonTitleText(
                                        textKey:
                                            "14000 ${AppLocalizations.of(context)!.lblEGP}",
                                        textWeight: FontWeight.w600,
                                        textFontSize:
                                            AppConstants.normalFontSize,
                                        textColor:
                                            AppConstants.lightOrangeColor,
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
                    itemCount: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
