import 'package:captien_omda_customer/core/form_builder_feature/presentation/form_widget/select_item_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared_texts.dart';
import '../../../presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../presentation/Widgets/common_requrid_text_widget.dart';
import '../../../presentation/Widgets/common_text_form_field_widget.dart';
import '../../domain/model/form_builder_model.dart';

class SelectionPopUpType extends StatelessWidget {
  final Function(dynamic) onApply;

  final bool? isMultiSelect;
  final bool? isListHaveSearch;
  final FormBuilderModel formModel;

  const SelectionPopUpType({
    Key? key,
    required this.onApply,
    required this.formModel,
    this.isMultiSelect = false,
    this.isListHaveSearch = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonRequiredText(
                textKey: formModel.labelText!,
                textColor: AppConstants.mainColor,
                textFontSize: AppConstants.mediumFontSize,
                textWeight: FontWeight.w500,
                textAlignment: TextAlign.start,
                isRequired: formModel.isRequired,
              ),
              CommonTextFormField(
                controller: TextEditingController(
                    text: formModel.value == null
                        ? AppLocalizations.of(context)!.lblNoting
                        : isMultiSelect!
                            ? getNameFromList(formModel.value)
                            : formModel.value.name),
                hintKey: formModel.hintText!,
                onTap: () {
                  advancedSearchPopUP(
                      context: context,
                      isMultiSelect: isMultiSelect,
                      multiSelectData: isMultiSelect!
                          ? formModel.value ?? []
                          : formModel.value == null
                              ? null
                              : [formModel.value],
                      onApply: onApply,
                      title: formModel.labelText!,
                      isListHaveSearch: isListHaveSearch,
                      listOfItem: formModel.parentId == null
                          ? formModel.optionGroup!
                              .where((element) => element.parentId == 0)
                              .toList()
                          : formModel.optionGroup!);
                },
                labelHintFontSize: AppConstants.mediumFontSize,
                labelHintColor: AppConstants.mainTextColor.withOpacity(0.4),
                filledColor: AppConstants.lightWhiteColor,
                borderColor: AppConstants.lightWhiteColor,
                focuseAndErrorColor: AppConstants.lightWhiteColor,
                isReadOnly: true,
                radius: AppConstants.containerOfListTitleBorderRadius,
                validator: (value) {
                  if (formModel.isRequired!) {
                    if (formModel.value == null) {
                      return formModel.requiredMessage;
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        RotatedBox(
          quarterTurns: SharedText.currentLocale == "ar" ? 0 : 2,
          child: const CommonAssetSvgImageWidget(
            imageString: 'left_arrow.svg',
            height: 24,
            width: 24,
            fit: BoxFit.cover,
            imageColor: AppConstants.lightRedColor,
          ),
        ),
      ],
    );
  }

  String getNameFromList(List<dynamic> listData) {
    String name = "";
    for (var element in listData) {
      name = "$name,${element.name}";
    }
    return name;
  }
}
