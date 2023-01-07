import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';

import '../../Helpers/shared_texts.dart';

class CommonAppBarImageWithCounter extends StatefulWidget {
  final String imagePath;
  final int itemCounter;
  final bool withCounter;

  const CommonAppBarImageWithCounter(
      {Key? key,
      required this.imagePath,
      this.itemCounter = 0,
      this.withCounter = false})
      : super(key: key);

  @override
  State<CommonAppBarImageWithCounter> createState() =>
      _CommonAppBarImageWithCounterState();
}

class _CommonAppBarImageWithCounterState
    extends State<CommonAppBarImageWithCounter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidgetWidth(36),
      height: getWidgetHeight(36),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: CommonAssetSvgImageWidget(
                  imageString: widget.imagePath, height: 22, width: 22),
            ),
            if (widget.withCounter)
              Positioned(
                top: getWidgetHeight(6),
                right: SharedText.isAppLocalAr() ? null : 3,
                left: SharedText.isAppLocalAr() ? 3 : null,
                child: Container(
                  height: getWidgetHeight(16),
                  width: getWidgetWidth(16),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.lightRedColor,
                  ),
                  child: Center(
                    child: CommonTitleText(
                      textKey: widget.itemCounter.toString(),
                      textColor: AppConstants.lightWhiteColor,
                      textFontSize: AppConstants.xxSmallFontSize,
                      minTextFontSize: AppConstants.xxSmallFontSize,
                      textWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
