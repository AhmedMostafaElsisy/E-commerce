import 'package:flutter/material.dart';

import '../../Helpers/shared_texts.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_global_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import 'common_title_text.dart';

class EmptyScreen extends StatelessWidget {
  final String imageString;
  final double imageHeight;
  final double imageWidth;
  final String titleKey;
  final String? description;
  final bool? withButton;
  final Function()? onTap;
  final String? buttonText;

  const EmptyScreen(
      {Key? key,
      required this.imageString,
      required this.titleKey,
      required this.imageHeight,
      required this.imageWidth,
      this.description,
      this.withButton = false,
      this.onTap,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SharedText.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CommonAssetSvgImageWidget(
                imageString: imageString,
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.fill),
          ),
          getSpaceHeight(16),
          Center(
            child: CommonTitleText(
              textKey: titleKey,
              textFontSize: AppConstants.xLargeFontSize,
              lines: 2,
              textOverflow: TextOverflow.ellipsis,
              textAlignment: TextAlign.center,
              textWeight: FontWeight.w700,
              textColor: AppConstants.lightBlackColor,
            ),
          ),
          if (description != null) ...[
            getSpaceHeight(8),
            Center(
              child: CommonTitleText(
                textKey: description!,
                textFontSize: AppConstants.normalFontSize,
                lines: 2,
                textOverflow: TextOverflow.ellipsis,
                textAlignment: TextAlign.center,
                textWeight: FontWeight.w500,
                textColor: AppConstants.lightBlackColor,
              ),
            ),
          ],
          if (withButton!) ...[
            getSpaceHeight(8),
            CommonGlobalButton(
                width: 140,
                height: 40,
                buttonBackgroundColor: AppConstants.verificationCodeColor,
                onPressedFunction: onTap ?? () {},
                buttonText:
                    buttonText ?? AppLocalizations.of(context)!.lblRetry,
                withIcon: false,
                buttonTextFontWeight: FontWeight.w400,
                elevation: 0,
                buttonTextColor: AppConstants.mainColor)
          ]
        ],
      ),
    );
  }
}
