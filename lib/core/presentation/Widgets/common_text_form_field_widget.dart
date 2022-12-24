import 'package:captien_omda_customer/core/Helpers/shared.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared_texts.dart';
import 'common_title_text.dart';

class CommonTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? textInputColor;
  final Function()? onTap;
  final bool enabled;
  final bool isSelected;
  final bool withPrefixIcon;
  final bool evaluation;
  final bool isObscureText;
  final bool isDigitOnly;
  final String? Function(String?)? validator;
  final bool withSuffixIcon;
  final double? fieldWidth;
  final double? fieldHeight;
  final int minLines;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? onChanged;
  final Function()? onSaved;
  final Color? borderColor;
  final Color? filledColor;
  final Color? labelHintStyle;
  final Color? labelErrorStyle;
  final List<TextInputFormatter>? inputFormatter;
  final bool? isReadOnly;
  final TextInputAction? action;
  final TextAlign? labelHintTextAlign;
  final double? radius;
  final bool? alignMultipleLines;
  final FocusNode? fieldFocusNode;
  final double? blurRadius;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;

  const CommonTextFormField({
    Key? key,
    this.labelText,
    this.hintKey,
    this.controller,
    this.keyboardType = TextInputType.name,
    this.onTap,
    this.enabled = true,
    this.isSelected = false,
    this.withPrefixIcon = true,
    this.isObscureText = false,
    this.evaluation = true,
    this.withSuffixIcon = false,
    this.fieldWidth,
    this.fieldHeight,
    this.isDigitOnly = false,
    this.minLines = 1,
    this.maxLines = 4,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.borderColor,
    this.filledColor = AppConstants.lightWhiteColor,
    this.textInputColor = AppConstants.lightBlackColor,
    this.labelHintStyle = AppConstants.transparent,
    this.labelErrorStyle = AppConstants.errorColor,
    this.inputFormatter,
    this.isReadOnly = false,
    this.action = TextInputAction.next,
    this.labelHintTextAlign = TextAlign.end,
    this.radius = 12.0,
    this.alignMultipleLines = false,
    this.fieldFocusNode,
    this.blurRadius = 40,
    this.shadowColor = AppConstants.shadowColor,
    this.shadowOffset = const Offset(0, 8),
    this.contentPaddingHorizontal=0,
    this.contentPaddingVertical=10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          CommonTitleText(
            textKey: labelText!,
            textColor: AppConstants.lightBlackColor,
            textFontSize: AppConstants.smallFontSize,
            textWeight: FontWeight.w600,
          ),
          getSpaceHeight(AppConstants.smallPadding),
        ],
        Container(
          height: fieldHeight,
          width: fieldWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              offset: shadowOffset!,
              blurRadius: blurRadius!,
              color: shadowColor!.withOpacity(0.10),
            )
          ]),
          child: Directionality(
            textDirection: SharedText.currentLocale == "ar"
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Center(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                minLines: minLines,
                maxLines: maxLines,
                enabled: enabled,
                onEditingComplete: onSaved,
                keyboardType: keyboardType,
                obscureText: isObscureText,
                onChanged: onChanged,
                readOnly: isReadOnly!,
                textAlign: labelHintTextAlign!,
                focusNode: fieldFocusNode,
                textInputAction: action,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: textInputColor,
                    ),
                inputFormatters: inputFormatter,
                validator: validator,
                cursorColor: AppConstants.mainColor,
                decoration: InputDecoration(
                  hintText: hintKey,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(
                          fontSize: AppConstants.smallFontSize,
                          fontWeight: FontWeight.w500)
                      .apply(
                        color: labelHintStyle,
                      ),
                  alignLabelWithHint: alignMultipleLines,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius!),
                    borderSide: const BorderSide(
                        color: AppConstants.transparent, width: 0.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius!),
                    borderSide: BorderSide(
                      color: borderColor ?? AppConstants.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius!),
                    borderSide: const BorderSide(
                      color: AppConstants.transparent,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius!),
                    borderSide: BorderSide(
                      color: borderColor ?? AppConstants.transparent,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(radius!)),
                      borderSide: const BorderSide(
                          color: AppConstants.errorColor, width: 0)),
                  errorStyle: const TextStyle(
                          fontSize: AppConstants.xSmallFontSize,
                          fontWeight: FontWeight.w500)
                      .apply(
                    color: labelErrorStyle,
                  ),
                  contentPadding:  EdgeInsets.symmetric(
                      vertical: contentPaddingVertical!, horizontal: contentPaddingHorizontal!),
                  fillColor: filledColor!,
                  isDense: true,
                  filled: true,
                  prefixIcon: withPrefixIcon ? prefixIcon : null,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                      .apply(
                        color: AppConstants.greyColor,
                      ),
                  suffixIcon: withSuffixIcon ? suffixIcon : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
