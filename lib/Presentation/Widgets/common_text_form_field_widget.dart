import 'package:default_repo_app/Constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  String? hintKey;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Color? textInputColor;
  Function()? onTap;
  bool enabled;
  bool isSelected;
  bool withPrefixIcon;
  bool evaluation;
  bool isObscureText;
  bool isDigitOnly;
  String? Function(String?)? validator;
  bool withSuffixIcon;
  double? fieldWidth;
  double? fieldHeight;
  int minLines;
  int maxLines;
  Widget? prefixIcon;

  Widget? suffixIcon;
  String? Function(String?)? onChanged;
  Function()? onSaved;
  Color? borderColor;
  Color? filledColor;
  Color? labelHintStyle;
  Color? labelErrorStyle;
  List<TextInputFormatter>? inputFormatter;
  bool? isReadOnly;
  TextInputAction? action;
  TextAlign? labelHintTextAlign;
  double? radius;
  bool? alignMultipleLines;
  FocusNode? fieldFocusNode;

  CommonTextFormField(
      {Key? key,
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
      this.textInputColor =  AppConstants.lightBlackColor,
      this.labelHintStyle = AppConstants.greyColor,
      this.labelErrorStyle = AppConstants.lightRedColor,
      this.inputFormatter,
      this.isReadOnly = false,
      this.action = TextInputAction.next,
      this.labelHintTextAlign = TextAlign.start,
      this.radius = 12.0,
      this.alignMultipleLines = false,
      this.fieldFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight,
      width: fieldWidth,
      alignment: Alignment.center,
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
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400)
                .apply(
                  color: labelHintStyle,
                ),
            alignLabelWithHint: alignMultipleLines,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide:
                  const BorderSide(color: AppConstants.greyColor, width: 0.3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: borderColor ?? AppConstants.greyColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: const BorderSide(
                color: AppConstants.mainColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: borderColor ?? AppConstants.greyColor.withOpacity(0.3),
              ),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius!)),
                borderSide: const BorderSide(
                    color: AppConstants.lightRedColor, width: 0)),
            errorStyle:
                const TextStyle(fontSize: 11, fontWeight: FontWeight.w400)
                    .apply(
              color: labelErrorStyle,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
    );
  }
}
