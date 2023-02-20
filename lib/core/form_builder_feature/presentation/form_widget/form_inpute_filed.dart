import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../Constants/Enums/form_builder_enum.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/Validators/validators.dart';
import '../../../Helpers/shared.dart';
import '../../../form_builder_feature/domain/model/form_builder_model.dart';
import '../../../presentation/Widgets/common_requrid_text_widget.dart';
import '../../../presentation/Widgets/common_text_form_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormInputFiled extends StatefulWidget {
  final FormBuilderModel formModel;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(
    FormBuilderModel,
  ) onChanged;

  const FormInputFiled(
      {Key? key,
      required this.formModel,
      this.keyboardType,
      this.inputFormatter,
      required this.onChanged})
      : super(key: key);

  @override
  State<FormInputFiled> createState() => _FormInputFiledState();
}

class _FormInputFiledState extends State<FormInputFiled> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(
        text: widget.formModel.defaultValueText.isEmpty
            ? null
            : widget.formModel.defaultValueText[0]["value"] == null
                ? null
                : widget.formModel.defaultValueText![0]["value"].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRequiredText(
          textKey: widget.formModel.labelText!,
          textColor: AppConstants.mainColor,
          textFontSize: AppConstants.mediumFontSize,
          textWeight: FontWeight.w500,
          textAlignment: TextAlign.start,
          isRequired: widget.formModel.isRequired,
        ),
        getSpaceHeight(AppConstants.pagePadding),
        CommonTextFormField(
          controller: textEditingController,
          hintKey: widget.formModel.hintText!,
          keyboardType: widget.keyboardType,
          labelHintFontSize: AppConstants.mediumFontSize,
          labelHintColor: AppConstants.mainTextColor.withOpacity(0.4),
          filledColor: AppConstants.lightWhiteColor,
          borderColor: AppConstants.borderInputColor,
          radius: AppConstants.containerOfListTitleBorderRadius,
          inputFormatter: widget.inputFormatter,
          validator: (value) {
            if (widget.formModel.isRequired!) {
              if (value!.isEmpty) {
                return widget.formModel.requiredMessage;
              } else if (widget.formModel.inputType == FormBuilderEnum.phone &&
                  (value.length != AppConstants.phoneLength)) {
                return AppLocalizations.of(context)!.lblPhoneValidate;
              } else if (widget.formModel.inputType == FormBuilderEnum.email &&
                  (!validateEmail(value))) {
                return AppLocalizations.of(context)!.lblEmailBadFormat;
              } else {
                return null;
              }
            } else {
              return null;
            }
          },
          onChanged: (value) {
            widget.formModel.value = {widget.formModel.key: value};
            widget.formModel.displaySelectedValue = value;
            widget.onChanged(widget.formModel);
            return null;
          },
        ),
      ],
    );
  }
}
