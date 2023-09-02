import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../presentation/Widgets/common_requrid_text_widget.dart';
import '../../../presentation/Widgets/common_text_form_field_widget.dart';
import '../../../presentation/Widgets/common_title_text.dart';
import '../../domain/model/form_builder_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormRangeWidget extends StatefulWidget {
  final FormBuilderModel formModel;
  final String? Function(
    FormBuilderModel,
  ) onChanged;

  const FormRangeWidget(
      {Key? key, required this.formModel, required this.onChanged})
      : super(key: key);

  @override
  State<FormRangeWidget> createState() => _FormRangeWidgetState();
}

class _FormRangeWidgetState extends State<FormRangeWidget> {
  late TextEditingController toController;
  late TextEditingController fromController;

  @override
  void initState() {
    super.initState();
    if (widget.formModel.defaultValueText != null &&
        widget.formModel.defaultValueText.isNotEmpty) {
      toController = TextEditingController(
        text: widget.formModel.defaultValueText[0]["value"] == null
            ? null
            : widget.formModel.defaultValueText[0]["value"][0].toString(),
      );
      fromController = TextEditingController(
        text: widget.formModel.defaultValueText[0]["value"] == null
            ? null
            : widget.formModel.defaultValueText[0]["value"][1].toString(),
      );
    } else {
      toController = TextEditingController();
      fromController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblFrom,
                    textColor: AppConstants.mainColor,
                    textFontSize: AppConstants.mediumFontSize,
                    textWeight: FontWeight.w500,
                    textAlignment: TextAlign.start,
                  ),
                  getSpaceHeight(AppConstants.pagePadding),
                  CommonTextFormField(
                    controller: toController,
                    hintKey: widget.formModel.hintText!,
                    keyboardType: TextInputType.number,
                    labelHintFontSize: AppConstants.mediumFontSize,
                    labelHintColor: AppConstants.mainTextColor.withOpacity(0.4),
                    filledColor: AppConstants.lightWhiteColor,
                    borderColor: AppConstants.borderInputColor,
                    radius: AppConstants.containerOfListTitleBorderRadius,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (widget.formModel.isRequired!) {
                        if (widget.formModel.isRequired! && value!.isEmpty) {
                          return widget.formModel.requiredMessage;
                        } else if (int.parse(value!) >=
                            int.parse(fromController.text)) {
                          return AppLocalizations.of(context)!.lblNoValid;
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      widget.formModel.value = {
                        "to": value!,
                        "from": fromController.text,
                      };
                      widget.formModel.displaySelectedValue =
                          "$value  -  ${fromController.text}";
                      widget.onChanged(widget.formModel);
                      return null;
                    },
                  ),
                ],
              ),
            ),
            getSpaceWidth(AppConstants.pagePadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblTo,
                    textColor: AppConstants.mainColor,
                    textFontSize: AppConstants.mediumFontSize,
                    textWeight: FontWeight.w500,
                    textAlignment: TextAlign.start,
                  ),
                  getSpaceHeight(AppConstants.pagePadding),
                  CommonTextFormField(
                    controller: fromController,
                    hintKey: widget.formModel.hintText!,
                    keyboardType: TextInputType.number,
                    labelHintFontSize: AppConstants.mediumFontSize,
                    labelHintColor: AppConstants.mainTextColor.withOpacity(0.4),
                    filledColor: AppConstants.lightWhiteColor,
                    borderColor: AppConstants.borderInputColor,
                    radius: AppConstants.containerOfListTitleBorderRadius,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (widget.formModel.isRequired!) {
                        if (value!.isEmpty) {
                          return widget.formModel.requiredMessage;
                        } else if (int.parse(value) <=
                            int.parse(toController.text)) {
                          return AppLocalizations.of(context)!.lblNoValid;
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      widget.formModel.value = {
                        "to": toController.text,
                        "from": value,
                      };
                      widget.formModel.displaySelectedValue =
                          "${toController.text}  -  $value";

                      widget.onChanged(widget.formModel);

                      return null;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
