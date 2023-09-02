import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

void pressAndHoldBottomSheet({
  context,
  double? height = 150,
  bool withDelete = true,
  Function()? deleteChatClicked,
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
              ],
            ),
          ));
}
