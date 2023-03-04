import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/tags_feature/presentation/logic/tags_cubit.dart';
import 'package:captien_omda_customer/core/tags_feature/presentation/logic/tags_states.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_cubit.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_states.dart';
import 'package:captien_omda_customer/features/general_prodcut_feature/presentation/logic/Filter_cubit/filter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/location_feature/presentation/area_pop_up.dart';
import '../../../../core/location_feature/presentation/city_pop_up.dart';
import '../../../../core/location_feature/presentation/logic/pick_location_cubit.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../logic/Filter_cubit/filter_cubit.dart';
import '../logic/product_list_cubit/product_list_cubit.dart';
import '../logic/product_list_cubit/product_list_events.dart';
import '../widget/common_wrap_item.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late FilterCubit filterCubit;
  late CategoriesCubit categoriesCubit;
  late TagsCubit tagsCubit;
  late PickLocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();
    filterCubit = BlocProvider.of<FilterCubit>(context);
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    tagsCubit = BlocProvider.of<TagsCubit>(context);
    filterCubit.initCubit();
    _locationCubit = BlocProvider.of<PickLocationCubit>(context);
    _locationCubit.getCityData(limit: 50);
    categoriesCubit.getAllCategories();
    tagsCubit.getTagsData(limit: 50);
    _locationCubit.clearAllData();
  }

  @override
  Widget build(BuildContext context) {
    return MainAppPage(
      screenContent: Scaffold(
        backgroundColor: AppConstants.transparent,
        appBar: CommonAppBar(
          withBack: true,
          appBarBackGroundColor: AppConstants.transparent,
          showBottomIcon: false,
          centerTitle: false,
          titleWidget: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblFilterTitle,
            textColor: AppConstants.lightBlackColor,
            textWeight: FontWeight.w400,
            textFontSize: AppConstants.normalFontSize,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: BlocConsumer<FilterCubit, FilterStates>(
            listener: (filterCtx, filterState) {
              if (filterState is FilterSuccessStates) {
                Navigator.of(context).pop();
                BlocProvider.of<ProductListCubitWithFilter>(context)
                    .add(SearchClickEvent());
              }
            },
            builder: (filterCtx, filterState) {
              ///area and city
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidgetWidth(16),
                  vertical: getWidgetHeight(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ///City
                        Expanded(
                          child: CommonTextFormField(
                            onTap: () {
                              showCityPopUp(
                                context: filterCtx,
                                title: AppLocalizations.of(filterCtx)!.lblCity,
                                onApply: (model) {
                                  filterCubit.userCityController.text =
                                      model.name!;
                                  filterCubit.setNewCitySelected(model);
                                  filterCubit.userAreaController.clear();
                                  _locationCubit.getAreaData(
                                      cityID: model.id!, limit: 50);
                                },
                                preSelectedCity: _locationCubit.selectedCity,
                              );
                            },
                            controller: filterCubit.userCityController,
                            hintKey: AppLocalizations.of(filterCtx)!.lblCity,
                            isReadOnly: true,
                            keyboardType: TextInputType.text,
                            labelHintColor: AppConstants.mainColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(filterCtx)!
                                    .lblNameIsEmpty;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              return null;
                            },
                          ),
                        ),

                        ///Spacer
                        getSpaceWidth(AppConstants.smallPadding),

                        ///Area
                        Expanded(
                          child: CommonTextFormField(
                            controller: filterCubit.userAreaController,
                            onTap: () {
                              if (filterCubit.selectedCity == null) {
                                showSnackBar(
                                  context: filterCtx,
                                  title: AppLocalizations.of(context)!
                                      .lblSelectCityFirst,
                                );
                              } else {
                                showAreaPopUp(
                                  context: filterCtx,
                                  title:
                                      AppLocalizations.of(filterCtx)!.lblArea,
                                  onApply: (model) {
                                    filterCubit.userAreaController.text =
                                        model.name!;
                                    filterCubit.setSelectedArea(model);
                                  },
                                  preSelectedCity: _locationCubit.selectedArea,
                                );
                              }
                            },
                            hintKey: AppLocalizations.of(filterCtx)!.lblArea,
                            keyboardType: TextInputType.text,
                            isReadOnly: true,
                            labelHintColor: AppConstants.mainColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(filterCtx)!
                                    .lblNameIsEmpty;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    getSpaceHeight(16),
                    BlocConsumer<CategoriesCubit, CategoryState>(
                        builder: (categoryCtx, categoryState) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  CommonTitleText(
                                    textKey: AppLocalizations.of(context)!
                                        .lblCategories,
                                    textColor: AppConstants.lightBlackColor,
                                    textWeight: FontWeight.w400,
                                    textFontSize: AppConstants.largeFontSize,
                                  ),
                                ],
                              ),
                              getSpaceHeight(16),
                              if (categoryState is CategoryLoadingState) ...[
                                const CircularProgressIndicator(),
                              ] else if (categoryState
                                  is GetCategoryFailedState) ...[
                                CommonError(
                                  errorMassage:
                                      categoryState.error.errorMassage,
                                  onTap: () {
                                    categoriesCubit.getAllCategories();
                                  },
                                )
                              ] else if (categoryState
                                  is GetCategorySuccessState) ...[
                                Wrap(
                                  children: List.generate(
                                    categoriesCubit.categories.length,
                                    (index) => CommonWrapItem(
                                      model: categoriesCubit.categories[index],
                                      onTap: (tappedModel) {
                                        filterCubit
                                            .setSelectedCategories(tappedModel);
                                      },
                                      isSelected: filterCubit
                                          .checkSelectedCategory(categoriesCubit
                                              .categories[index]),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          );
                        },
                        listener: (categoryCtx, categoryState) {}),
                    getSpaceHeight(16),
                    BlocConsumer<TagsCubit, TagsLocationStates>(
                        builder: (tagsCtx, tagsState) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  CommonTitleText(
                                    textKey: AppLocalizations.of(context)!
                                        .lblCategories,
                                    textColor: AppConstants.lightBlackColor,
                                    textWeight: FontWeight.w400,
                                    textFontSize: AppConstants.largeFontSize,
                                  ),
                                ],
                              ),
                              getSpaceHeight(16),
                              if (tagsState is TagsLoadingState) ...[
                                const CircularProgressIndicator(),
                              ] else if (tagsState is TagsErrorState) ...[
                                CommonError(
                                  errorMassage: tagsState.error?.errorMassage,
                                  onTap: () {
                                    categoriesCubit.getAllCategories();
                                  },
                                )
                              ] else if (tagsState is TagsSuccessState) ...[
                                Wrap(
                                  children: List.generate(
                                    tagsCubit.tagsList.length,
                                    (index) => CommonWrapItem(
                                      model: tagsCubit.tagsList[index],
                                      onTap: (tappedModel) {
                                        filterCubit
                                            .setSelectedTags(tappedModel);
                                      },
                                      isSelected: filterCubit.checkSelectedTags(
                                          tagsCubit.tagsList[index]),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          );
                        },
                        listener: (tagsCtx, tagsState) {}),
                    const Spacer(),
                    CommonGlobalButton(
                      height: 48,
                      buttonBackgroundColor: AppConstants.mainColor,
                      isEnable: true,
                      isLoading: false,
                      buttonTextSize: AppConstants.normalFontSize,
                      buttonTextFontWeight: FontWeight.w700,
                      buttonText: AppLocalizations.of(context)!.lblApply,
                      onPressedFunction: () {
                        filterCubit.apply();
                      },
                    ),
                    getSpaceHeight(24)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
