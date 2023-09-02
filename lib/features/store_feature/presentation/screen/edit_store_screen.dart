import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/location_feature/presentation/area_pop_up.dart';
import '../../../../core/location_feature/presentation/city_pop_up.dart';
import '../../../../core/location_feature/presentation/logic/pick_location_cubit.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/Widgets/select_item_pop_up.dart';
import '../../../../core/presentation/Widgets/take_photo_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../../core/presentation/search_filter_cubit/search_filet_cubit.dart';
import '../../../../core/tags_feature/presentation/logic/tags_cubit.dart';
import '../../../Categories_feature/presentation/logic/category_cubit.dart';
import '../logic/edit_my_store/edit_my_store_cubit.dart';
import '../logic/edit_my_store/edit_my_store_states.dart';

class EditStoreScreen extends StatefulWidget {
  final RouteArgument argument;

  const EditStoreScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<EditStoreScreen> createState() => _EditStoreScreenState();
}

class _EditStoreScreenState extends State<EditStoreScreen> {
  late EditStoreCubit _editStoreCubit;
  final formKey = GlobalKey<FormState>();
  late PickLocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();
    _editStoreCubit = BlocProvider.of<EditStoreCubit>(context);
    _locationCubit = BlocProvider.of<PickLocationCubit>(context);
    AllFilterCubit.get(context).clearAll();
    _locationCubit.getCityData(limit: 50);
    _locationCubit.getAreaData(
        cityID: widget.argument.shopModel!.city!.id!, limit: 50);
    _locationCubit.clearAllData();
    _editStoreCubit.setNewCitySelected(widget.argument.shopModel!.city!);
    _editStoreCubit.setSelectedArea(widget.argument.shopModel!.area!);
    _editStoreCubit.setSelectedCategory(widget.argument.shopModel!.category!);
    _editStoreCubit.setSelectedTags(widget.argument.shopModel!.subCategory!);
    _editStoreCubit.storeNameController =
        TextEditingController(text: widget.argument.shopModel!.name!);
    _editStoreCubit.ownerNameController =
        TextEditingController(text: widget.argument.shopModel!.ownerName!);
    _editStoreCubit.emailAddressController =
        TextEditingController(text: widget.argument.shopModel!.email!);
    _editStoreCubit.phoneNumberController =
        TextEditingController(text: widget.argument.shopModel!.phone!);

    _editStoreCubit.userAddressController =
        TextEditingController(text: widget.argument.shopModel!.address!);
    _editStoreCubit.userCityController =
        TextEditingController(text: widget.argument.shopModel!.city!.name);
    _editStoreCubit.userAreaController =
        TextEditingController(text: widget.argument.shopModel!.area!.name);
    _editStoreCubit.storeMainCategoryController =
        TextEditingController(text: widget.argument.shopModel!.category!.name);
    _editStoreCubit.storeSubCategoryController = TextEditingController(
        text: getNameFromList(widget.argument.shopModel!.subCategory!));
    _editStoreCubit.isDataFound = false;
    _editStoreCubit.controllerList.clear();
    _editStoreCubit.controllerList.add(_editStoreCubit.storeNameController);
    _editStoreCubit.controllerList.add(_editStoreCubit.ownerNameController);
    _editStoreCubit.controllerList.add(_editStoreCubit.emailAddressController);
    _editStoreCubit.controllerList.add(_editStoreCubit.phoneNumberController);
    _editStoreCubit.controllerList.add(_editStoreCubit.userAddressController);
    _editStoreCubit.controllerList.add(_editStoreCubit.userCityController);
    _editStoreCubit.controllerList.add(_editStoreCubit.userAreaController);
    _editStoreCubit.controllerList
        .add(_editStoreCubit.storeMainCategoryController);
    _editStoreCubit.controllerList
        .add(_editStoreCubit.storeSubCategoryController);
    _editStoreCubit.isDataFount(_editStoreCubit.controllerList);
  }

  @override
  void dispose() {
    _editStoreCubit.storeNameController.dispose();
    _editStoreCubit.ownerNameController.dispose();
    _editStoreCubit.emailAddressController.dispose();
    _editStoreCubit.phoneNumberController.dispose();
    _editStoreCubit.userAddressController.dispose();
    _editStoreCubit.userCityController.dispose();
    _editStoreCubit.userAreaController.dispose();
    _editStoreCubit.storeMainCategoryController.dispose();
    _editStoreCubit.storeSubCategoryController.dispose();
    _editStoreCubit.imageXFile = null;
    _editStoreCubit.clearAllData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainAppPage(
          screenContent: Column(
            children: [
              CommonAppBar(
                withBack: true,
                appBarBackGroundColor: AppConstants.transparent,
                showBottomIcon: false,
                centerTitle: false,
                titleWidget: CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblEditStore,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              BlocConsumer<EditStoreCubit, EditMyStoreState>(
                listener: (storeCtx, storeState) {
                  if (storeState is EditStoreFailedStates) {
                    checkUserAuth(
                        context: storeCtx, errorType: storeState.error.type);
                    showSnackBar(
                      context: storeCtx,
                      title: storeState.error.errorMassage!,
                    );
                  } else if (storeState is EditStoreSuccessStates) {
                    showSnackBar(
                        context: storeCtx,
                        title:
                            AppLocalizations.of(context)!.lblStoreEditSuccess,
                        color: AppConstants.successColor);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.mainBottomNavPageRoute,
                      (route) => false,
                    );
                  }
                },
                builder: (storeCtx, storeState) {
                  return Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.pagePadding),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: [
                              Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      ///shop logo
                                      InkWell(
                                        onTap: () {
                                          takePhotoBottomSheet(
                                              context: context,
                                              getPhoto: storeCtx
                                                  .read<EditStoreCubit>()
                                                  .photoPicked);
                                        },
                                        child: Container(
                                          width: SharedText.screenWidth,
                                          height: getWidgetHeight(48),
                                          decoration: BoxDecoration(
                                            color: AppConstants.lightWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color:
                                                    AppConstants.lightGrayColor,
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 8),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _editStoreCubit.imageXFile !=
                                                          null
                                                      ? commonFileImageWidget(
                                                          imageString:
                                                              _editStoreCubit
                                                                  .imageXFile!
                                                                  .path,
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.fill)
                                                      : commonCachedImageWidget(
                                                          widget
                                                              .argument
                                                              .shopModel!
                                                              .image!,
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.fill,
                                                        ),
                                                  const CommonAssetSvgImageWidget(
                                                      imageString: "upload.svg",
                                                      height: 24,
                                                      width: 24),
                                                ]),
                                          ),
                                        ),
                                      ),

                                      ///Spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///store name
                                      CommonTextFormField(
                                        controller:
                                            _editStoreCubit.storeNameController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblShopName,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblNameIsEmpty;
                                          } else if (nameValidator(value)) {
                                            return AppLocalizations.of(context)!
                                                .lblNameBadFormat;
                                          } else if (value.length < 2) {
                                            return AppLocalizations.of(context)!
                                                .lblNameLength;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///Spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///owner name
                                      CommonTextFormField(
                                        controller:
                                            _editStoreCubit.ownerNameController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblShopOwnerName,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblNameIsEmpty;
                                          } else if (nameValidator(value)) {
                                            return AppLocalizations.of(context)!
                                                .lblNameBadFormat;
                                          } else if (value.length < 2) {
                                            return AppLocalizations.of(context)!
                                                .lblNameLength;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Phone
                                      CommonTextFormField(
                                        controller: _editStoreCubit
                                            .phoneNumberController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblShopPhone,
                                        keyboardType: TextInputType.phone,
                                        labelHintColor: AppConstants.mainColor,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblPhoneIsEmpty;
                                          } else if (value.length <
                                              AppConstants.phoneLength) {
                                            return AppLocalizations.of(context)!
                                                .lblPhoneValidate;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Email
                                      CommonTextFormField(
                                        controller: _editStoreCubit
                                            .emailAddressController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblShopEmail,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            if (!validateEmail(value)) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblEmailBadFormat;
                                            } else {
                                              return null;
                                            }
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///address
                                      CommonTextFormField(
                                        minLines: 3,
                                        maxLines: 5,
                                        controller: _editStoreCubit
                                            .userAddressController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblShopAddressDetails,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblNameIsEmpty;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///area and city
                                      Row(
                                        children: [
                                          ///City
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller: _editStoreCubit
                                                  .userCityController,
                                              hintKey:
                                                  AppLocalizations.of(context)!
                                                      .lblCity,
                                              onTap: () {
                                                showCityPopUp(
                                                    context: storeCtx,
                                                    preSelectedCity:
                                                        _editStoreCubit
                                                                .selectedCity ??
                                                            widget
                                                                .argument
                                                                .shopModel!
                                                                .city!,
                                                    title: AppLocalizations.of(
                                                            storeCtx)!
                                                        .lblCity,
                                                    onApply: (model) {
                                                      _editStoreCubit
                                                          .userCityController
                                                          .text = model.name!;
                                                      _editStoreCubit
                                                          .setNewCitySelected(
                                                              model);
                                                      _editStoreCubit
                                                          .userAreaController
                                                          .clear();
                                                      _locationCubit
                                                          .getAreaData(
                                                              cityID: model.id!,
                                                              limit: 50);
                                                      _editStoreCubit.isDataFount(
                                                          _editStoreCubit
                                                              .controllerList);
                                                    });
                                              },
                                              isReadOnly: true,
                                              keyboardType: TextInputType.text,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .lblNameIsEmpty;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _editStoreCubit.isDataFount(
                                                    _editStoreCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),

                                          ///Spacer
                                          getSpaceWidth(
                                              AppConstants.smallPadding),

                                          ///Area
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller: _editStoreCubit
                                                  .userAreaController,
                                              hintKey:
                                                  AppLocalizations.of(context)!
                                                      .lblArea,
                                              isReadOnly: true,
                                              onTap: () {
                                                showAreaPopUp(
                                                    context: storeCtx,
                                                    preSelectedCity:
                                                        _editStoreCubit
                                                            .selectedArea,
                                                    title: AppLocalizations.of(
                                                            storeCtx)!
                                                        .lblArea,
                                                    onApply: (model) {
                                                      _editStoreCubit
                                                          .userAreaController
                                                          .text = model.name!;
                                                      _editStoreCubit
                                                          .setSelectedArea(
                                                              model);
                                                      _editStoreCubit.isDataFount(
                                                          _editStoreCubit
                                                              .controllerList);
                                                    });
                                              },
                                              keyboardType: TextInputType.text,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .lblNameIsEmpty;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _editStoreCubit.isDataFount(
                                                    _editStoreCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///main category
                                      CommonTextFormField(
                                        controller: _editStoreCubit
                                            .storeMainCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblMainCategory,
                                        onTap: () {
                                          advancedSearchPopUP(
                                            context: context,
                                            isMultiSelect: false,
                                            title: AppLocalizations.of(context)!
                                                .lblMainCategory,
                                            multiSelectData: [_editStoreCubit.selectedCategory!],
                                            isListHaveSearch: true,
                                            listOfItem: BlocProvider.of<
                                                CategoriesCubit>(context)
                                                .categories,
                                            onApply: (dynamic) {
                                              _editStoreCubit
                                                  .storeMainCategoryController
                                                  .text = dynamic.name;
                                              _editStoreCubit
                                                  .setSelectedCategory(dynamic);
                                              _editStoreCubit.isDataFount(
                                                  _editStoreCubit.controllerList);
                                            },
                                          );
                                        },
                                        isReadOnly: true,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblNameIsEmpty;
                                          } else if (nameValidator(value)) {
                                            return AppLocalizations.of(context)!
                                                .lblNameBadFormat;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///sub category
                                      CommonTextFormField(
                                        controller: _editStoreCubit
                                            .storeSubCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblSubCategory,
                                        onTap: () {
                                          advancedSearchPopUP(
                                            context: context,
                                            isMultiSelect: true,
                                            multiSelectData:
                                            _editStoreCubit.selectedTag,
                                            title: AppLocalizations.of(context)!
                                                .lblSubCategory,
                                            isListHaveSearch: true,
                                            listOfItem:
                                            BlocProvider.of<TagsCubit>(
                                                context)
                                                .tagsList,
                                            onApply: (dynamic) {
                                              _editStoreCubit.setSelectedTags(
                                                  List.from(dynamic));
                                              _editStoreCubit
                                                  .storeSubCategoryController
                                                  .text =
                                                  getNameFromList(
                                                      List.from(dynamic));
                                              _editStoreCubit.isDataFount(
                                                  _editStoreCubit.controllerList);
                                            },
                                          );
                                        },
                                        isReadOnly: true,
                                        keyboardType: TextInputType.text,
                                        labelHintColor: AppConstants.mainColor,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .lblNameIsEmpty;
                                          } else if (nameValidator(value)) {
                                            return AppLocalizations.of(context)!
                                                .lblNameBadFormat;
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          _editStoreCubit.isDataFount(
                                              _editStoreCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonGlobalButton(
                                            height: 48,
                                            buttonBackgroundColor:
                                                AppConstants.mainColor,
                                            isEnable:
                                                _editStoreCubit.isDataFound,
                                            isLoading: storeState
                                                is EditStoreLoadingStates,
                                            buttonTextSize: 18,
                                            buttonTextFontWeight:
                                                FontWeight.w600,
                                            buttonText:
                                                AppLocalizations.of(context)!
                                                    .lblSave,
                                            onPressedFunction: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                storeCtx
                                                    .read<EditStoreCubit>()
                                                    .editStore(
                                                  planId: widget.argument
                                                      .shopModel!.plansModel!.id! ,
                                                      storeId: widget.argument
                                                          .shopModel!.id!,
                                                      storeImage:
                                                          _editStoreCubit
                                                              .imageXFile,
                                                    );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  String getNameFromList(List<dynamic> listData) {
    String name = "";
    for (var element in listData) {
      name = "$name , ${element.name}";
    }
    return name;
  }
}
