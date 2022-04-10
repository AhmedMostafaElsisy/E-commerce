import 'package:flutter/material.dart';


import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import 'common_icon_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common_title_text.dart';

class CommonGlobalButton extends StatelessWidget {
  final bool withIcon;
  final String buttonText;
  final Function() onPressedFunction;
  final Color? buttonBackgroundColor;
  final Color? onPressedColor;
  final Color? shadowBackgroundColor;
  final double? elevation;
  final double? width;
  final double? height;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final FontWeight? buttonTextFontWeight;
  final Color? iconColor;
  final double? radius;
  final double? iconSize;
  final IconData? iconData;
  final double? spaceSize;
  final bool isLoading;

  const CommonGlobalButton({
    Key? key,
    required this.buttonText,
    required this.onPressedFunction,
    required this.withIcon,
    this.buttonBackgroundColor,
    this.onPressedColor,
    this.shadowBackgroundColor,
    this.elevation = 5.0,
    this.width = 343,
    this.height = 40,
    this.iconColor = AppConstants.lightWhiteColor,
    this.buttonTextColor = AppConstants.lightWhiteColor,
    this.buttonTextFontWeight = FontWeight.normal,
    this.buttonTextSize = 14,
    this.iconData,
    this.radius = 45.0,
    this.iconSize = 13.0,
    this.spaceSize = 13.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = getWidgetWidth(width!);
    double buttonHeight = getWidgetHeight(height!);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressedFunction,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation!),
        shadowColor: MaterialStateProperty.all(
          shadowBackgroundColor ?? AppConstants.greyColor.withOpacity(.3),
        ),
        overlayColor: MaterialStateProperty.all(
          onPressedColor ?? AppConstants.greyColor.withOpacity(.25),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        fixedSize:
            MaterialStateProperty.all<Size>(Size(buttonWidth, buttonHeight)),
        backgroundColor:isLoading? MaterialStateProperty.all(
          AppConstants.greyColor):MaterialStateProperty.all(
            buttonBackgroundColor ?? AppConstants.mainColor),
      ),
      child: withIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonIcon(
                  iconData ?? Icons.arrow_forward,
                  iconColor!,
                  iconSize!,
                ),
                getSpaceWidth(spaceSize!),
                Expanded(
                  child: CommonTitleText(
                    textKey: isLoading
                        ? AppLocalizations.of(context)!.lblLoading
                        : buttonText,
                    textColor: buttonTextColor!,
                    textFontSize: buttonTextSize!,
                    textWidget: buttonTextFontWeight!,
                  ),
                ),
              ],
            )
          : CommonTitleText(
              textKey: isLoading
                  ? AppLocalizations.of(context)!.lblLoading
                  : buttonText,
              textColor: buttonTextColor!,
              textFontSize: buttonTextSize!,
              textWidget: buttonTextFontWeight!,
            ),
    );
  }
}
