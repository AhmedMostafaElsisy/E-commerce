import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
void deletePhotoFunction({
  context,
  required Function() onDelete,

}) {
  showModalBottomSheet(
      backgroundColor: AppConstants.transparent,
      barrierColor: AppConstants.lightBlackColor.withOpacity(.34),
      context: context,
      builder: (_) => Container(
            width: double.infinity,
            height: getWidgetHeight(120),
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
                    height: getWidgetHeight(4),
                    color: AppConstants.lightBlackColor,
                  ),
                ),
                getSpaceHeight(20),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(_).pop();
                    onDelete();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getSpaceWidth(18),
                      const CommonAssetSvgImageWidget(
                          imageString: 'bin_icon.svg', height: 18, width: 20,
                      imageColor: AppConstants.lightRedColor,
                      ),
                      getSpaceWidth(10),
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblDeletePhoto,
                        textFontSize: AppConstants.largeFontSize,
                        textColor: AppConstants.lightRedColor,
                      )
                    ],
                  ),
                ),

              ],
            ),
          ));
}
