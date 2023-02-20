import 'dart:developer';

import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Constants/Enums/form_builder_enum.dart';
import '../domain/model/form_option_model.dart';
import 'form_widget/form_inpute_filed.dart';
import 'form_widget/form_range_widget.dart';
import 'form_widget/product_details_spacer.dart';
import 'form_widget/selection_pop_up_types.dart';
import 'form_widget/selection_type.dart';
import 'logic/form_builder_cubit.dart';
import 'logic/form_builder_state.dart';

class FormDataScreen extends StatefulWidget {
  final int? categoryId;

  const FormDataScreen({Key? key, this.categoryId}) : super(key: key);

  @override
  State<FormDataScreen> createState() => _FormDataScreenState();
}

class _FormDataScreenState extends State<FormDataScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormBuilderCubit, FormBuilderState>(
        listener: (formCtx, formState) {},
        builder: (formCtx, formState) {
          if (formState is GetCategoryFormLoadingStates) {
            return const CommonLoadingWidget();
          } else if (formState is GetCategoryFormErrorStates) {
            return CommonError(
              errorMassage: formState.error.errorMassage,
              withButton: true,
              onTap: () {
                if (widget.categoryId != null) {
                  formCtx
                      .read<FormBuilderCubit>()
                      .getProductForm(categoryId: widget.categoryId!);
                }
              },
            );
          } else {
            return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  switch (formCtx
                      .read<FormBuilderCubit>()
                      .formList[index]
                      .inputType!) {
                    case FormBuilderEnum.init:
                      return const SizedBox();
                    case FormBuilderEnum.radio:
                      return SelectionType(
                        isRequired: formCtx.read<FormBuilderCubit>().formList[index].isRequired!,
                       title: formCtx.read<FormBuilderCubit>().formList[index].labelText! ,
                        onItemSelected: (value){

                          formCtx.read<FormBuilderCubit>().formList[index].value=value;
                          formCtx
                              .read<FormBuilderCubit>()
                              .formList[index]
                              .displaySelectedValue = value.name!;
                          log("this selection value ${ formCtx.read<FormBuilderCubit>().formList[index].value}");
                          formCtx.read<FormBuilderCubit>().updateView();
                        },
                        optionsToSelect: formCtx.read<FormBuilderCubit>().formList[index].optionGroup!,
                        selectedItem:  formCtx.read<FormBuilderCubit>().formList[index].value,
                      );
                    case FormBuilderEnum.text:
                      return FormInputFiled(
                        keyboardType: TextInputType.text,
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onChanged: (value) {
                          formCtx.read<FormBuilderCubit>().updateView();
                          return null;
                        },
                      );
                    case FormBuilderEnum.number:
                      return FormInputFiled(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                        ],
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onChanged: (value) {
                          formCtx.read<FormBuilderCubit>().updateView();
                          return null;
                        },
                      );
                    case FormBuilderEnum.email:
                      return FormInputFiled(
                        keyboardType: TextInputType.emailAddress,
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onChanged: (value) {
                          formCtx.read<FormBuilderCubit>().updateView();
                          return null;
                        },
                      );
                    case FormBuilderEnum.phone:
                      return FormInputFiled(
                        keyboardType: TextInputType.phone,
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onChanged: (value) {
                          formCtx.read<FormBuilderCubit>().updateView();
                          return null;
                        },
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      );
                    case FormBuilderEnum.rang:
                      return FormRangeWidget(
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onChanged: (value) {
                          formCtx.read<FormBuilderCubit>().updateView();
                          return null;
                        },
                      );
                    case FormBuilderEnum.checkbox:
                      return SelectionPopUpType(
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onApply: (dynamic) {
                          formCtx
                                  .read<FormBuilderCubit>()
                                  .formList[index]
                                  .value =
                              dynamic.isEmpty ? null : List.from(dynamic);
                          formCtx
                                  .read<FormBuilderCubit>()
                                  .formList[index]
                                  .displaySelectedValue =
                              getNameFromList(formCtx
                                  .read<FormBuilderCubit>()
                                  .formList[index]
                                  .value);
                          formCtx.read<FormBuilderCubit>().updateView();
                        },
                        isMultiSelect: true,
                        isListHaveSearch: true,
                      );

                    case FormBuilderEnum.select:
                      return SelectionPopUpType(
                        formModel:
                            formCtx.read<FormBuilderCubit>().formList[index],
                        onApply: (dynamic) {
                          formCtx
                              .read<FormBuilderCubit>()
                              .formList[index]
                              .displaySelectedValue = dynamic.name;

                          if (formCtx
                              .read<FormBuilderCubit>()
                              .formList[index]
                              .isReactive!) {
                            FormOptionModel childOption = formCtx
                                .read<FormBuilderCubit>()
                                .formList[index]
                                .optionGroup!
                                .firstWhere(
                                    (element) => element.parentId == dynamic.id);
                            formCtx
                                .read<FormBuilderCubit>()
                                .createNewFiledFromOption(
                                    formCtx
                                        .read<FormBuilderCubit>()
                                        .formList[index],
                                    childOption,
                                    oldChild: formCtx
                                        .read<FormBuilderCubit>()
                                        .formList[index]
                                        .value);
                          }
                          formCtx
                              .read<FormBuilderCubit>()
                              .formList[index]
                              .value = dynamic;
                          formCtx.read<FormBuilderCubit>().updateView();
                        },
                        isMultiSelect: false,
                        isListHaveSearch: true,
                      );
                  }
                },
                separatorBuilder: (context, index) {
                  if (formCtx
                          .read<FormBuilderCubit>()
                          .formList[index]
                          .inputType ==
                      FormBuilderEnum.init) {
                    return const SizedBox();
                  } else {
                    return const ProductDetailsSpacer();
                  }
                },
                itemCount: formCtx.read<FormBuilderCubit>().formList.length);
          }
        });
  }

  String getNameFromList(List<dynamic> listData) {
    String name = "";
    for (var element in listData) {
      name = "$name,${element.name}";
    }
    return name;
  }
}
