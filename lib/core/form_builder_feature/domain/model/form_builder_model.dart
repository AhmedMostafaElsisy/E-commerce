import 'package:captien_omda_customer/core/Constants/Enums/form_builder_enum.dart';
import 'form_option_model.dart';
List<FormBuilderModel> formBuilderListFromJson(List str) =>
    List<FormBuilderModel>.from(str.map((x) => FormBuilderModel.fromJson(x)));

List<FormBuilderModel> formFilterBuilderListFromJson(List str) =>
    List<FormBuilderModel>.from(
        str.map((x) => FormBuilderModel.fromFilterJson(x)));

class FormBuilderModel {
  int? id;
  String? key;
  int? order;
  FormBuilderEnum? inputType;
  String? labelText;
  String? placeHolderText;
  String? requiredMessage;
  String? hintText;
  dynamic defaultValueText;
  bool? isReactive;
  bool? hasOptions;
  bool? isRequired;
  dynamic reactiveFiled;
  dynamic reactiveWhere;
  dynamic value;
  List<FormOptionModel>? optionGroup;
  String? displaySelectedValue;
  int? parentId;

  FormBuilderModel(
      {this.id,
      this.key,
      this.order,
      this.inputType,
      this.labelText,
      this.placeHolderText,
      this.requiredMessage,
      this.hintText,
      this.defaultValueText,
      this.isReactive,
      this.hasOptions,
      this.isRequired,
      this.reactiveFiled,
      this.reactiveWhere,
      this.optionGroup,
      this.parentId,
      this.value});

  factory FormBuilderModel.fromJson(Map<String, dynamic> json) {
    FormBuilderEnum getFormType(String type) {
      switch (type) {
        case 'text':
          return FormBuilderEnum.text;
        case 'number':
          return FormBuilderEnum.number;
        case 'email':
          return FormBuilderEnum.email;
        case 'tel':
          return FormBuilderEnum.phone;
        case 'rang':
          return FormBuilderEnum.rang;
        case 'checkbox':
          return FormBuilderEnum.checkbox;
        case 'radio':
          return FormBuilderEnum.radio;
        case 'select':
          return FormBuilderEnum.select;
        default:
          return FormBuilderEnum.init;
      }
    }

    return FormBuilderModel(
      id: json["id"],
      key: json["key"],
      order: json["order"],
      inputType: getFormType(json["type"] ?? ""),
      labelText: json["label"],
      placeHolderText: json["placeholder"],
      requiredMessage: json["required_message"],
      hintText: json["hint"],
      defaultValueText: json["default"] is String
          ? [
              {"value": null}
            ]
          : json["default"]?? [
        {"value": null}
      ],
      isReactive: json["is_reactive"],
      hasOptions: json["has_options"],
      isRequired: json["is_required"],
      reactiveFiled: json["reactive_field"],
      reactiveWhere: json["reactive_where"],
      optionGroup: json["options"] == null
          ? []
          : formOptionBuilderListFromJson(json["options"]),
      value: null
    );
  }

  factory FormBuilderModel.fromFilterJson(Map<String, dynamic> json) {
    FormBuilderEnum getFormType(String type) {
      switch (type) {
        case 'text':
          return FormBuilderEnum.text;
        case 'number':
          return FormBuilderEnum.number;
        case 'email':
          return FormBuilderEnum.email;
        case 'tel':
          return FormBuilderEnum.phone;
        case 'rang':
          return FormBuilderEnum.rang;
        case 'checkbox':
          return FormBuilderEnum.checkbox;
        case 'radio':
          return FormBuilderEnum.radio;
          case 'select':
          return FormBuilderEnum.select;
        default:
          return FormBuilderEnum.init;
      }
    }

    return FormBuilderModel(
      id: json["id"],
      key: json["key"],
      order: json["order"],
      inputType: getFormType(json["type"] ?? ""),
      labelText: json["label"],
      placeHolderText: json["placeholder"],
      requiredMessage: json["required_message"],
      hintText: json["hint"],
      defaultValueText: json["default"] is String
          ? [
        {"value": null}
      ]
          : json["default"]?? [
        {"value": null}
      ],
      isReactive: json["is_reactive"],
      hasOptions: json["has_options"],
      isRequired: false,
      reactiveFiled: json["reactive_field"],
      reactiveWhere: json["reactive_where"],
      optionGroup: json["options"] == null
          ? []
          : formOptionBuilderListFromJson(json["options"]),
    );
  }

  FormBuilderModel copyWith(FormOptionModel optionModel) {
    return FormBuilderModel(
      id: id,
      key: key,
      inputType: inputType,
      labelText: optionModel.name,
      isReactive: false,
      defaultValueText: defaultValueText,
      hasOptions: hasOptions,
      hintText: hintText,
      isRequired: isRequired,
      optionGroup: optionGroup!.where((element) => element.parentId==optionModel.parentId).toList(),
      order: order,
      placeHolderText: placeHolderText,
      reactiveFiled: reactiveFiled,
      reactiveWhere: reactiveWhere,
      requiredMessage: requiredMessage,
      value: null,
      parentId: optionModel.parentId
    );
  }
  FormBuilderModel editCopyWith(FormOptionModel optionModel) {
    return FormBuilderModel(
      id: id,
      key: key,
      inputType: inputType,
      labelText: optionModel.name,
      isReactive: false,
      defaultValueText: defaultValueText,
      hasOptions: hasOptions,
      hintText: hintText,
      isRequired: isRequired,
      optionGroup: optionGroup!.where((element) => element.parentId==optionModel.parentId).toList(),
      order: order,
      placeHolderText: placeHolderText,
      reactiveFiled: reactiveFiled,
      reactiveWhere: reactiveWhere,
      requiredMessage: requiredMessage,
      value: optionModel,
      parentId: optionModel.parentId
    );
  }

  @override
  String toString() {
    return 'FormBuilderModel{id: $id, key: $key, order: $order, inputType: $inputType, labelText: $labelText, placeHolderText: $placeHolderText, requiredMessage: $requiredMessage, hintText: $hintText, defaultValueText: $defaultValueText, isReactive: $isReactive, hasOptions: $hasOptions, isRequired: $isRequired, reactiveFiled: $reactiveFiled, reactiveWhere: $reactiveWhere, value: $value, optionGroup: $optionGroup, displaySelectedValue: $displaySelectedValue, parentId: $parentId}';
  }
}
