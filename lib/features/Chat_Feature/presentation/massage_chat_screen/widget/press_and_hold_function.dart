import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

void pressAndHoldBottomSheet({
  context,
  double? height = 190,
  bool withDelete = true,
  bool showArchive = true,
  bool showFavorite = true,
  bool? isFavorite = false,
  bool? isArchive = false,
  Function()? favoriteClicked,
  Function()? deleteChatClicked,
  Function()? archiveChatClicked,
}) {
  showModalBottomSheet(
      backgroundColor: AppConstants.transparentColor,
      barrierColor: AppConstants.lightBlackColor.withOpacity(.34),
      context: context,
      builder: (_) => Container(
            width: double.infinity,
            height: getWidgetHeight(height!),
            decoration: const BoxDecoration(
              color: AppConstants.lightWhiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppConstants.pagePadding - 1),
                  topLeft: Radius.circular(AppConstants.pagePadding - 1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getSpaceHeight(12),
                Center(
                  child: Container(
                    width: getWidgetWidth(65),
                    height: getWidgetHeight(5),
                    decoration: BoxDecoration(
                        color: AppConstants.borderInputColor.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(AppConstants.borderRadius)),
                  ),
                ),
                getSpaceHeight(20),
                if (showFavorite) ...[
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      favoriteClicked!();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getSpaceWidth(18),
                        const CommonAssetSvgImageWidget(
                            imageString: 'navbar_favourite.svg',
                            height: 18,
                            width: 20,
                            imageColor: AppConstants.mainColor),
                        getSpaceWidth(10),
                        CommonTitleText(
                          textKey: isFavorite!
                              ? AppLocalizations.of(context)!.lblRemoveFromFav
                              : AppLocalizations.of(context)!.lblAddToFav,
                          textFontSize: AppConstants.largeFontSize,
                          textWeight: FontWeight.w600,
                          textColor: AppConstants.mainColor,
                        )
                      ],
                    ),
                  ),
                ],
                if (withDelete) ...[
                  getSpaceHeight(24),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: deleteChatClicked,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getSpaceWidth(18),
                        const CommonAssetSvgImageWidget(
                            imageString: 'trash_bin.svg',
                            height: 18,
                            width: 20),
                        getSpaceWidth(10),
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!.lblRemoveChat,
                          textFontSize: AppConstants.largeFontSize,
                          textWeight: FontWeight.w600,
                          textColor: AppConstants.mainColor,
                        )
                      ],
                    ),
                  ),
                ],
                if (showArchive) ...[
                  getSpaceHeight(24),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: archiveChatClicked,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getSpaceWidth(18),
                        const CommonAssetSvgImageWidget(
                            imageString: 'search_history.svg',
                            height: 18,
                            width: 20),
                        getSpaceWidth(10),
                        CommonTitleText(
                          textKey: isArchive!
                              ? AppLocalizations.of(context)!
                                  .lblRemoveFromArchive
                              : AppLocalizations.of(context)!.lblAddToArchive,
                          textFontSize: AppConstants.largeFontSize,
                          textWeight: FontWeight.w600,
                          textColor: AppConstants.mainColor,
                        )
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ));
}
