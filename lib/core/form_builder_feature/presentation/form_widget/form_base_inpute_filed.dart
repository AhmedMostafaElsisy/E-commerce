import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../presentation/Widgets/common_requrid_text_widget.dart';
import '../../../presentation/Widgets/common_text_form_field_widget.dart';

class FormInputBaseFiled extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Widget? withExtraItem;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(String?)? validator;
final bool ?isRequired;
  const FormInputBaseFiled(
      {Key? key,
        required this.controller,
        required this.title,
        this.keyboardType,
        this.withExtraItem,
        this.inputFormatter,
        this.validator,
        this.isRequired=true,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRequiredText(
          textKey: title,
          isRequired: isRequired,
          textColor: AppConstants.mainColor,
          textFontSize: AppConstants.mediumFontSize,
          textWeight: FontWeight.w500,
          textAlignment: TextAlign.start,
        ),
        getSpaceHeight(AppConstants.pagePadding),
        CommonTextFormField(
          controller: controller,
          hintKey: " ",
          keyboardType: keyboardType,
          labelHintFontSize: AppConstants.mediumFontSize,
          labelHintColor: AppConstants.mainTextColor.withOpacity(0.4),
          filledColor: AppConstants.lightWhiteColor,
          borderColor: AppConstants.borderInputColor,
          radius: AppConstants.containerOfListTitleBorderRadius,
          inputFormatter: inputFormatter,
          validator: validator,
        ),
        withExtraItem ?? const SizedBox()
      ],
    );
  }
}
