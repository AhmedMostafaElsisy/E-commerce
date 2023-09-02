import 'package:captien_omda_customer/core/form_builder_feature/presentation/form_widget/product_details_spacer.dart';
import 'package:captien_omda_customer/core/form_builder_feature/presentation/form_widget/select_multi_item.dart';
import 'package:captien_omda_customer/core/form_builder_feature/presentation/form_widget/select_single_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../presentation/Widgets/common_empty_widget.dart';
import '../../../presentation/Widgets/common_global_button.dart';
import '../../../presentation/Widgets/common_text_form_field_widget.dart';
import '../../../presentation/Widgets/common_title_text.dart';
import '../../../presentation/search_filter_cubit/search_filet_cubit.dart';
import '../../../presentation/search_filter_cubit/search_filter_staets.dart';

/// model list pop up with search
advancedSearchPopUP({
  required BuildContext context,
  required String title,
  required Function(dynamic) onApply,
  required List<dynamic> listOfItem,
  List<dynamic>? multiSelectData,
  bool? isMultiSelect = false,
  bool? isListHaveSearch = true,
}) async {
  AllFilterCubit.get(context).setList(listOfItem);
  if (isMultiSelect!) {
    AllFilterCubit.get(context).setMultiModelData(multiSelectData!);
  } else {
    if (multiSelectData != null) {
      AllFilterCubit.get(context).setModelSingleSelect(multiSelectData.first);
    }
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
                  borderRadius: BorderRadius.circular(
                      AppConstants.containerOfListTitleBorderRadius),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.pagePadding),
                  decoration: BoxDecoration(
                      color: AppConstants.lightWhiteColor,
                      borderRadius: BorderRadius.circular(
                          AppConstants.containerOfListTitleBorderRadius)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// close button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                getWidgetWidth(AppConstants.pagePadding)),
                        child: Row(
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidgetWidth(
                                        AppConstants.pagePadding)),
                                child: CommonTextFormField(
                                  hintKey: AppLocalizations.of(context)!
                                      .lblSearchHere,
                                  onChanged: (val) {
                                    filterCtx
                                        .read<AllFilterCubit>()
                                        .searchInList(val!);
                                    return;
                                  },
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CommonAssetSvgImageWidget(
                                        imageColor: AppConstants.mainColor,
                                        imageString: 'search_icon.svg',
                                        height: 15,
                                        width: 15),
                                  ),
                                  borderColor: AppConstants.mainColor,
                                ),
                              ),

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
                              ListView.separated(
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
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
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getWidgetWidth(
                                                  AppConstants.pagePadding)),
                                          child: isMultiSelect
                                              ? PopUpMultiItem(
                                                  name: filterCtx
                                                      .read<AllFilterCubit>()
                                                      .listOfModelsTemp[index]
                                                      .name
                                                      .toString(),
                                                  isSelected: filterCtx
                                                      .read<AllFilterCubit>()
                                                      .isModelSelected(
                                                          filterCtx
                                                              .read<
                                                                  AllFilterCubit>()
                                                              .listOfModelsTemp[index],
                                                          isMultiSelect),
                                                )
                                              : PopUpSingleItem(
                                                  name: filterCtx
                                                      .read<AllFilterCubit>()
                                                      .listOfModelsTemp[index]
                                                      .name
                                                      .toString(),
                                                  isSelected: filterCtx
                                                      .read<AllFilterCubit>()
                                                      .isModelSelected(
                                                          filterCtx
                                                              .read<
                                                                  AllFilterCubit>()
                                                              .listOfModelsTemp[index],
                                                          isMultiSelect),
                                                ),
                                        ));
                                  },
                                  separatorBuilder: (context, index) {
                                    return isMultiSelect
                                        ? getSpaceHeight(
                                            AppConstants.pagePadding)
                                        : Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: getWidgetWidth(
                                                    AppConstants.pagePadding)),
                                            child: const ProductDetailsSpacer(
                                              spaceValue:
                                                  AppConstants.smallPadding,
                                            ),
                                          );
                                  },
                                  itemCount: filterCtx
                                      .read<AllFilterCubit>()
                                      .listOfModelsTemp
                                      .length),
                            ],
                          ],
                        ),
                      ),
                      getSpaceHeight(20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                getWidgetWidth(AppConstants.pagePadding)),
                        child: CommonGlobalButton(
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
                              onApply(
                                  filterCtx.read<AllFilterCubit>().modelItem);
                            }

                            Navigator.pop(context);
                          },
                        ),
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
