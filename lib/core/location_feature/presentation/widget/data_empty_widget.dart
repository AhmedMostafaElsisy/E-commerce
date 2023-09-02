
import 'package:flutter/material.dart';

import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../Helpers/shared_texts.dart';
import '../../../presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../presentation/Widgets/common_global_button.dart';
import '../../../presentation/Widgets/common_title_text.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String imageString;
  final String title;
  final String hint;
  final String? buttonText;
  final bool showButton;
  final VoidCallback? onTap;
  final Color? buttonBackGroundColor;
  final Color? buttonTextColor;
  const NoDataFoundWidget({
    Key? key,
    required this.imageString,
    required this.title,
    this.hint = "",
    this.showButton = false,
    this.buttonText,
    this.onTap,
    this.buttonBackGroundColor=AppConstants.verificationCodeColor,
    this.buttonTextColor=AppConstants.mainColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SharedText.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// Icon
          CommonAssetSvgImageWidget(
            imageString: imageString,
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ),

          /// Space
          getSpaceHeight(24),
          CommonTitleText(
            textKey: title,
            textWeight: FontWeight.w700,
            textFontSize: AppConstants.normalFontSize,
            textColor: AppConstants.lightBlackColor,
          ),

          /// Space
          if (hint.isNotEmpty) ...[
            getSpaceHeight(16),
            CommonTitleText(
              lines: 6,
              minTextFontSize: AppConstants.smallFontSize,
              textAlignment: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              textKey: hint,
              textWeight: FontWeight.w400,
              textFontSize: AppConstants.smallFontSize,
              textColor: AppConstants.lightGrayShadowColor,
            ),
          ],

          getSpaceHeight(16),

          if (showButton) ...[
            CommonGlobalButton(
              height: 48,
              width: 160,
              buttonBackgroundColor:buttonBackGroundColor!,
              isEnable: true,
              isLoading: false,
              radius: AppConstants.smallBorderRadius,
              buttonTextSize: 18,
              buttonTextFontWeight: FontWeight.w400,
              buttonTextColor: buttonTextColor!,
              buttonText: buttonText!,
              onPressedFunction: onTap!,
              withIcon: false,
            ),
          ]
        ],
      ),
    );
  }
}
