import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_global_button.dart';
import 'common_title_text.dart';

class CommonError extends StatelessWidget {
  final String? errorMassage;
  final bool? withButton;
  final Function()? onTap;

  const CommonError(
      {Key? key, this.errorMassage, this.withButton = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: commonAssetSvgImageWidget(
              imageString: "error_icon.svg",
              height: 80,
              width: 80,
              fit: BoxFit.fill),
        ),
        getSpaceHeight(16),
        CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblWrongHappen,
          textFontSize: AppConstants.normalFontSize,
          textOverflow: TextOverflow.ellipsis,
          textAlignment: TextAlign.center,
          textWeight: FontWeight.w700,
          textColor: AppConstants.lightBlackColor,
        ),
        getSpaceHeight(8),
        Row(
          children: [
            Expanded(
              child: CommonTitleText(
                textKey: errorMassage == null
                    ? AppLocalizations.of(context)!.lblWrongHappen
                    : errorMassage!.isEmpty
                        ? AppLocalizations.of(context)!.lblWrongHappen
                        : errorMassage!,
                textFontSize: AppConstants.normalFontSize,
                minTextFontSize: AppConstants.normalFontSize,
                textWeight: FontWeight.w400,
                textColor: AppConstants.lightGrayShadowColor,
                textOverflow: TextOverflow.ellipsis,
                textAlignment: TextAlign.center,
                lines: 2,
              ),
            ),
          ],
        ),
        if (withButton!) ...[
          getSpaceHeight(20),
          CommonGlobalButton(
              radius: AppConstants.smallRadius,
              width: 140,
              height: 40,
              buttonBackgroundColor: AppConstants.verificationCodeColor,
              onPressedFunction: onTap ?? () {},
              buttonText: AppLocalizations.of(context)!.lblRetry,
              withIcon: false,
              buttonTextFontWeight: FontWeight.w400,
              elevation: 0,
              buttonTextColor: AppConstants.mainColor)
        ]
      ],
    );
  }
}
