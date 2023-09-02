import 'package:captien_omda_customer/core/presentation/Widgets/pop_up_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import '../search_filter_cubit/search_filet_cubit.dart';
import '../search_filter_cubit/search_filter_staets.dart';
import 'common_asset_svg_image_widget.dart';
import 'common_empty_widget.dart';
import 'common_global_button.dart';
import 'common_text_form_field_widget.dart';
import 'common_title_text.dart';

/// model list pop up with search
advancedSearchPopUP({
  required BuildContext context,
  required String title,
  required Function(dynamic) onApply,
  required List<dynamic> listOfItem,
  List<dynamic>? multiSelectData,
  bool? isMultiSelect = false,
  bool? isListHaveSearch = true,
  dynamic preSelectedData,
}) async {
  AllFilterCubit.get(context).setList(listOfItem);
  if (isMultiSelect!) {
    AllFilterCubit.get(context).setMultiModelData(multiSelectData ?? []);
    AllFilterCubit.get(context).setModelMultiSelect(preSelectedData ?? []);
  } else {
    if (multiSelectData != null) {
      AllFilterCubit.get(context).setModelSingleSelect(multiSelectData.first);
    }
    AllFilterCubit.get(context).setModelSingleSelect(preSelectedData);
  }
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocConsumer<AllFilterCubit, AllFilterCubitState>(
            listener: (filterCtx, filterState) {},
            builder: (filterCtx, filterState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.pagePadding),
                  color: AppConstants.lightWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTitleText(
                            textKey: title,
                            textWeight: FontWeight.w400,
                            textFontSize: AppConstants.smallFontSize,
                            textColor: AppConstants.mainColor,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CommonAssetSvgImageWidget(
                                  imageString: "close.svg",
                                  height: 16,
                                  width: 16))
                        ],
                      ),

                      ///spacer
                      getSpaceHeight(20),

                      ///list
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            if (isListHaveSearch!) ...[
                              /// Search filed

                              CommonTextFormField(
                                  hintKey: AppLocalizations.of(context)!
                                      .lblSearchHere,
                                  onChanged: (val) {
                                    filterCtx
                                        .read<AllFilterCubit>()
                                        .searchInList(val!);

                                    return;
                                  },
                                  withSuffixIcon: true,
                                  keyboardType: TextInputType.text,
                                  radius: AppConstants.smallRadius,
                                  prefixIcon: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: const CommonAssetSvgImageWidget(
                                          imageString: "search.svg",
                                          height: 16,
                                          width: 16,
                                          fit: BoxFit.fill))),

                              /// Space
                              getSpaceHeight(16),
                            ],
                            if (filterCtx
                                .read<AllFilterCubit>()
                                .listOfModelsTemp
                                .isEmpty) ...[
                              EmptyScreen(
                                  imageString: "empty_search.svg",
                                  titleKey: AppLocalizations.of(context)!
                                      .lblNoResultFount,
                                  description: AppLocalizations.of(context)!
                                      .lblAdjustYourSearch,
                                  imageHeight: 200,
                                  imageWidth: 200),
                            ] else ...[
                              ///list of items

                              GridView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: filterCtx
                                    .read<AllFilterCubit>()
                                    .listOfModelsTemp
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      if (isMultiSelect) {
                                        filterCtx
                                            .read<AllFilterCubit>()
                                            .setModelMultiSelect(filterCtx
                                                .read<AllFilterCubit>()
                                                .listOfModelsTemp[index]);
                                      } else {
                                        filterCtx
                                            .read<AllFilterCubit>()
                                            .setModelSingleSelect(filterCtx
                                                .read<AllFilterCubit>()
                                                .listOfModelsTemp[index]);
                                      }
                                    },
                                    child: PopUpItemWidget(
                                      isSelected: filterCtx
                                          .read<AllFilterCubit>()
                                          .isModelSelected(
                                              filterCtx
                                                  .read<AllFilterCubit>()
                                                  .listOfModelsTemp[index],
                                              isMultiSelect),
                                      name: filterCtx
                                          .read<AllFilterCubit>()
                                          .listOfModelsTemp[index]
                                          .name
                                          .toString(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      getSpaceHeight(20),
                      CommonGlobalButton(
                        height: 48,
                        buttonBackgroundColor: AppConstants.mainColor,
                        isEnable: isMultiSelect
                            ? filterCtx
                                .read<AllFilterCubit>()
                                .listOfSelectedModelItem
                                .isNotEmpty
                            : filterCtx.read<AllFilterCubit>().modelItem !=
                                null,
                        isLoading: false,
                        radius: AppConstants.containerOfListTitleBorderRadius,
                        buttonTextSize: 18,
                        buttonTextFontWeight: FontWeight.w400,
                        buttonText: AppLocalizations.of(context)!.lblConfirm,
                        onPressedFunction: () {
                          if (isMultiSelect) {
                            onApply(filterCtx
                                .read<AllFilterCubit>()
                                .listOfSelectedModelItem);
                          } else {
                            onApply(filterCtx.read<AllFilterCubit>().modelItem);
                          }

                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
