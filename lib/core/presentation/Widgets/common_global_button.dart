import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_title_text.dart';

class CommonGlobalButton extends StatelessWidget {
  final bool? withIcon;
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
  final bool isEnable;
  final bool showBorder;
  final Color? borderColor;

  const CommonGlobalButton(
      {Key? key,
      required this.buttonText,
      required this.onPressedFunction,
       this.withIcon=false,
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
      this.radius = AppConstants.containerBorderRadius,
      this.iconSize = 13.0,
      this.spaceSize = 13.0,
      this.isLoading = false,
      this.isEnable = true,
      this.showBorder = false,
      this.borderColor = AppConstants.mainColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = getWidgetWidth(width!);
    double buttonHeight = getWidgetHeight(height!);

    return ElevatedButton(
      onPressed: isLoading || !isEnable ? null : onPressedFunction,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation!),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            width: 1,
            color: showBorder ? borderColor! : AppConstants.lightWhiteColor,
          ),
        ),
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
        backgroundColor: isLoading || !isEnable
            ? MaterialStateProperty.all(AppConstants.greyColor)
            : MaterialStateProperty.all(
                buttonBackgroundColor ?? AppConstants.mainColor),
      ),
      child: withIcon!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTitleText(
                  textKey: isLoading
                      ? AppLocalizations.of(context)!.lblLoading
                      : buttonText,
                  textColor: isEnable
                      ? isLoading
                          ? AppConstants.lightWhiteColor
                          : buttonTextColor!
                      : AppConstants.lightWhiteColor,
                  textFontSize: buttonTextSize!,
                  textWeight: buttonTextFontWeight!,
                ),
                getSpaceWidth(spaceSize!),
                const commonAssetSvgImageWidget(
                    imageString: "right_arrow.svg", height: 8, width: 14)
              ],
            )
          : CommonTitleText(
              textKey: isLoading
                  ? AppLocalizations.of(context)!.lblLoading
                  : buttonText,
              textColor: isEnable
                  ? isLoading
                      ? AppConstants.lightWhiteColor
                      : buttonTextColor!
                  : AppConstants.lightWhiteColor,
              textFontSize: buttonTextSize!,
              textWeight: buttonTextFontWeight!,
            ),
    );
  }
}
