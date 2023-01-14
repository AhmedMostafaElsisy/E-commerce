import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:captien_omda_customer/features/favorite_feature/presentation/logic/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import '../../../features/Profile_feature/presentation/screens/common_profile_header_widget.dart';
import '../../../features/favorite_feature/presentation/logic/favorite_cubit.dart';
import '../Routes/route_argument_model.dart';
import '../Routes/route_names.dart';
import 'common_global_button.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel model;
  final bool? showActionButton;
  final bool? showFavIcon;

  const ProductItemWidget(
      {Key? key,
      required this.model,
      this.showActionButton = false,
      this.showFavIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      width: getWidgetWidth(168),
      // height: getWidgetHeight(300),
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: BorderRadius.circular(
              AppConstants.containerOfListTitleBorderRadius),
          boxShadow: [
            BoxShadow(
                color: AppConstants.lightBlackColor.withOpacity(0.16),
                offset: const Offset(0, 0),
                blurRadius: 4)
          ]),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ///product image
        Stack(
          children: [
            commonCachedImageWidget(
              model.image!,
              height: 168,
              width: 168,
              fit: BoxFit.contain,
            ),
            if (showFavIcon!)
              Positioned(
                  top: getWidgetHeight(8),
                  right: getWidgetWidth(8),
                  child: BlocConsumer<FavoriteCubit, FavoriteStates>(
                    listener: (favCtx, favState) {
                      if (favState is FavoriteRemoveFavSuccessStates) {
                        if (favState.productId == model.id) {
                          model.isFav = false;
                        }
                      } else if (favState is FavoriteAddFavSuccessStates) {
                        if (favState.productId == model.id) {
                          model.isFav = true;
                        }
                      }
                    },
                    builder: (favCtx, favState) {
                      if (favState is FavoriteFavLoadingStates &&
                          favState.productId == model.id) {
                        return SizedBox(
                            height: getWidgetHeight(14),
                            width: getWidgetWidth(14),
                            child: const CircularProgressIndicator(
                              color: AppConstants.mainColor,
                            ));
                      }
                      return CommonProfileHeaderWidget(
                        imagePath:
                            model.isFav! ? "fav_enable.svg" : "fav_disable.svg",
                        imageHeight: 14,
                        imageWidth: 14,
                        onClick: () {
                          if (favState is! FavoriteFavLoadingStates) {
                            model.isFav!
                                ? favCtx
                                    .read<FavoriteCubit>()
                                    .removeItemFromFav(productId: model.id!)
                                : favCtx
                                    .read<FavoriteCubit>()
                                    .addItemToFav(productId: model.id!);
                          }
                        },
                      );
                    },
                  )),
          ],
        ),

        ///spacer
        getSpaceHeight(4),

        ///product name
        CommonTitleText(
          textKey: model.name!,
          textFontSize: AppConstants.smallFontSize,
          textColor: AppConstants.mainColor,
          textWeight: FontWeight.w600,
        ),

        ///Spacer
        getSpaceHeight(4),

        ///product price
        CommonTitleText(
          textKey: currencyFormat.format(int.parse(model.price!)) +
              AppLocalizations.of(context)!.lblEGP,
          textFontSize: AppConstants.smallFontSize,
          textColor: AppConstants.starRatingColor,
          textWeight: FontWeight.w700,
        ),

        ///Spacer
        getSpaceHeight(4),

        ///Shop information
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Shop image
            commonCachedImageWidget(model.shopModel!.image!,
                height: 24,
                width: 24,
                fit: BoxFit.fill,
                isCircular: true,
                isProfile: true,
                radius: 1000),

            ///Spacer
            getSpaceWidth(4),

            ///shop name
            CommonTitleText(
              textKey: model.shopModel!.name!,
              textFontSize: AppConstants.smallFontSize,
              textColor: AppConstants.mainTextColor,
              textWeight: FontWeight.w400,
            ),
          ],
        ),

        ///Spacer
        getSpaceHeight(4),

        ///Product words
        CommonTitleText(
          textKey: model.description!,
          textFontSize: AppConstants.xxSmallFontSize,
          textColor: AppConstants.lightContentColor,
          textWeight: FontWeight.w400,
        ),

        ///Spacer
        getSpaceHeight(4),

        ///Divider
        const Divider(
          color: AppConstants.greyColor,
          thickness: 0.2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///product time
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonAssetSvgImageWidget(
                    imageString: "time.svg",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                  getSpaceWidth(4),
                  CommonTitleText(
                    textKey: model.time!,
                    textFontSize: AppConstants.xxSmallFontSize,
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
                  ),
                  getSpaceWidth(4),
                  CommonTitleText(
                    textKey: model.shopModel!.location!,
                    textFontSize: AppConstants.xxSmallFontSize,
                    textColor: AppConstants.lightContentColor,
                    textWeight: FontWeight.w400,
                  ),
                ],
              ),

              ///Action button
            ],
          ),
        ),
        if (showActionButton!) ...[
          getSpaceHeight(AppConstants.smallPadding),
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
                            RouteNames.showProductPageRoute,
                            arguments: RouteArgument(productModel: model));
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
                            RouteNames.editProductPageRoute,
                            arguments: RouteArgument(productModel: model));
                      },
                      height: 32,
                      radius: AppConstants.containerBorderRadius,
                      withIcon: false),
                ),
              ],
            ),
          ),
        ]
      ]),
    );
  }
}
