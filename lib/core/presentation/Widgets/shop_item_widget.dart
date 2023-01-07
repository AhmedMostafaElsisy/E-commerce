import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/shop_model.dart';
import 'common_global_button.dart';

class ShopItemWidget extends StatelessWidget {
  final ShopModel model;

  const ShopItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: getWidgetWidth(168),
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
          boxShadow: [
            BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.16),
                offset: const Offset(0, 0),
                blurRadius: 4)
          ]),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ///shop image
        commonCachedImageWidget(context, model.image!,
            height: 168, width: 168, fit: BoxFit.fill),

        ///spacer
        getSpaceHeight(8),

        ///shop name
        CommonTitleText(
          textKey: model.name!,
          textFontSize: AppConstants.smallFontSize,
          textColor: AppConstants.mainTextColor,
          textWeight: FontWeight.w600,
        ),

        ///Spacer
        getSpaceHeight(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///shop category
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonAssetSvgImageWidget(
                    imageString: "category.svg",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                    imageColor: AppConstants.mainColor,
                  ),
                  getSpaceWidth(4),
                  CommonTitleText(
                    textKey: model.category ?? "asd",
                    textFontSize: AppConstants.xSmallFontSize,
                    textColor: AppConstants.lightContentColor,
                    textWeight: FontWeight.w400,
                  ),
                ],
              ),

              ///shop location
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonAssetSvgImageWidget(
                    imageString: "location.svg",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                    imageColor: AppConstants.mainColor,
                  ),
                  getSpaceWidth(4),
                  CommonTitleText(
                    textKey: model.location ?? "asda",
                    textFontSize: AppConstants.xSmallFontSize,
                    textColor: AppConstants.lightContentColor,
                    textWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),

        ///Spacer
        getSpaceHeight(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Show
              Expanded(
                child: CommonGlobalButton(
                    showBorder: false,
                    buttonTextFontWeight: FontWeight.w600,
                    buttonTextSize: AppConstants.normalFontSize,
                    elevation: 0,
                    buttonBackgroundColor: AppConstants.mainColor,
                    buttonText: AppLocalizations.of(context)!.lblShow,
                    onPressedFunction: () {
                      Navigator.of(context).pushNamed(
                          RouteNames.viewMyStoresPageRoute,
                          arguments: RouteArgument(shopModel: model));
                    },
                    height: 32,
                    radius: AppConstants.containerBorderRadius,
                    withIcon: false),
              ),
              getSpaceWidth(8),

              /// edit
              Expanded(
                child: CommonGlobalButton(
                    showBorder: true,
                    borderColor: AppConstants.mainColor,
                    buttonTextFontWeight: FontWeight.w600,
                    buttonTextSize: AppConstants.normalFontSize,
                    elevation: 0,
                    buttonBackgroundColor: AppConstants.lightWhiteColor,
                    buttonTextColor: AppConstants.mainColor,
                    buttonText: AppLocalizations.of(context)!.lblEdit,
                    onPressedFunction: () {

                      Navigator.of(context).pushNamed(
                          RouteNames.editStoresPageRoute,
                          arguments: RouteArgument(shopModel: model));
                    },
                    height: 32,
                    radius: AppConstants.containerBorderRadius,
                    withIcon: false),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
