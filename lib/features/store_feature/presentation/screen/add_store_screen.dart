import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/core/tags_feature/presentation/logic/tags_cubit.dart';
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
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/Widgets/select_item_pop_up.dart';
import '../../../../core/presentation/Widgets/take_photo_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../logic/my_stores_cubit/store_cubit.dart';
import '../logic/my_stores_cubit/store_states.dart';
import '../../../../core/presentation/search_filter_cubit/search_filet_cubit.dart';
import '../../../Categories_feature/presentation/logic/category_cubit.dart';
import '../logic/general_store_cubit/store_cubit.dart';
import '../logic/general_store_cubit/store_states.dart';

class AddStoreScreen extends StatefulWidget {
  final RouteArgument argument;

  const AddStoreScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  late StoreCubit _storeCubit;
  final formKey = GlobalKey<FormState>();
  late PickLocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    _locationCubit = BlocProvider.of<PickLocationCubit>(context);
    AllFilterCubit.get(context).clearAll();
    _locationCubit.getCityData(limit: 50);
    _locationCubit.clearAllData();
    _storeCubit.clearAllData();
    _storeCubit.storeNameController = TextEditingController();
    _storeCubit.ownerNameController = TextEditingController();
    _storeCubit.emailAddressController = TextEditingController();
    _storeCubit.phoneNumberController = TextEditingController();

    _storeCubit.userAddressController = TextEditingController();
    _storeCubit.userCityController = TextEditingController();
    _storeCubit.userAreaController = TextEditingController();
    _storeCubit.storeMainCategoryController = TextEditingController();
    _storeCubit.storeSubCategoryController = TextEditingController();
    _storeCubit.isDataFound = false;
    _storeCubit.controllerList.clear();
    _storeCubit.controllerList.add(_storeCubit.storeNameController);
    _storeCubit.controllerList.add(_storeCubit.ownerNameController);
    _storeCubit.controllerList.add(_storeCubit.emailAddressController);
    _storeCubit.controllerList.add(_storeCubit.phoneNumberController);
    _storeCubit.controllerList.add(_storeCubit.userAddressController);
    _storeCubit.controllerList.add(_storeCubit.userCityController);
    _storeCubit.controllerList.add(_storeCubit.userAreaController);
    _storeCubit.controllerList.add(_storeCubit.storeMainCategoryController);
    _storeCubit.controllerList.add(_storeCubit.storeSubCategoryController);
  }

  @override
  void dispose() {
    _storeCubit.storeNameController.dispose();
    _storeCubit.ownerNameController.dispose();
    _storeCubit.emailAddressController.dispose();
    _storeCubit.phoneNumberController.dispose();
    _storeCubit.userAddressController.dispose();
    _storeCubit.userCityController.dispose();
    _storeCubit.userAreaController.dispose();
    _storeCubit.storeMainCategoryController.dispose();
    _storeCubit.storeSubCategoryController.dispose();
    _storeCubit.imageXFile = null;
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
                  textKey: AppLocalizations.of(context)!.lblAddStore,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              BlocConsumer<StoreCubit, StoreStates>(
                listener: (storeCtx, storeState) {
                  if (storeState is CreateStoreFailedStates) {
                    // checkUserAuth(
                    //     context: storeCtx, errorType: storeState.error.type);
                    showSnackBar(
                      context: storeCtx,
                      title: storeState.error.errorMassage!,
                    );
                  } else if (storeState is CreateStoreSuccessStates) {
                    if(! widget
                        .argument.firstStoreCreate!){
                      showSnackBar(
                          context: storeCtx,
                          title: AppLocalizations.of(context)!
                              .lblStoreCreatedSuccess,
                          color: AppConstants.successColor);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.mainBottomNavPageRoute,
                            (route) => false,
                      );
                    }

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
                                                  .read<StoreCubit>()
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
                                                  _storeCubit.imageXFile != null
                                                      ? commonFileImageWidget(
                                                          imageString:
                                                              _storeCubit
                                                                  .imageXFile!
                                                                  .path,
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.fill)
                                                      : CommonTitleText(
                                                          textKey:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .lblShopLogo,
                                                          textWeight:
                                                              FontWeight.w500,
                                                          textColor:
                                                              AppConstants
                                                                  .mainColor,
                                                          textFontSize:
                                                              AppConstants
                                                                  .smallFontSize,
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
                                            _storeCubit.storeNameController,
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///Spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///owner name
                                      CommonTextFormField(
                                        controller:
                                            _storeCubit.ownerNameController,
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Phone
                                      CommonTextFormField(
                                        controller:
                                            _storeCubit.phoneNumberController,
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Email
                                      CommonTextFormField(
                                        controller:
                                            _storeCubit.emailAddressController,
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///address
                                      CommonTextFormField(
                                        minLines: 3,
                                        maxLines: 5,
                                        controller:
                                            _storeCubit.userAddressController,
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
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
                                              onTap: () {
                                                showCityPopUp(
                                                    context: storeCtx,
                                                    title: AppLocalizations.of(
                                                            storeCtx)!
                                                        .lblCity,
                                                    onApply: (model) {
                                                      _storeCubit
                                                          .userCityController
                                                          .text = model.name!;
                                                      _storeCubit
                                                          .setNewCitySelected(
                                                              model);
                                                      _storeCubit
                                                          .userAreaController
                                                          .clear();
                                                      _locationCubit
                                                          .getAreaData(
                                                              cityID: model.id!,
                                                              limit: 50);
                                                      _storeCubit.isDataFount(
                                                          _storeCubit
                                                              .controllerList);
                                                    });
                                              },
                                              controller: _storeCubit
                                                  .userCityController,
                                              hintKey:
                                                  AppLocalizations.of(storeCtx)!
                                                      .lblCity,
                                              isReadOnly: true,
                                              keyboardType: TextInputType.text,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          storeCtx)!
                                                      .lblNameIsEmpty;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _storeCubit.isDataFount(
                                                    _storeCubit.controllerList);
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
                                              controller: _storeCubit
                                                  .userAreaController,
                                              onTap: () {
                                                if (_storeCubit.selectedCity ==
                                                    null) {
                                                  showSnackBar(
                                                    context: storeCtx,
                                                    title: AppLocalizations.of(
                                                            context)!
                                                        .lblSelectCityFirst,
                                                  );
                                                } else {
                                                  showAreaPopUp(
                                                      context: storeCtx,
                                                      title:
                                                          AppLocalizations.of(
                                                                  storeCtx)!
                                                              .lblArea,
                                                      onApply: (model) {
                                                        _storeCubit
                                                            .userAreaController
                                                            .text = model.name!;
                                                        _storeCubit
                                                            .setSelectedArea(
                                                                model);
                                                        _storeCubit.isDataFount(
                                                            _storeCubit
                                                                .controllerList);
                                                      });
                                                }
                                              },
                                              hintKey:
                                                  AppLocalizations.of(storeCtx)!
                                                      .lblArea,
                                              keyboardType: TextInputType.text,
                                              isReadOnly: true,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          storeCtx)!
                                                      .lblNameIsEmpty;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _storeCubit.isDataFount(
                                                    _storeCubit.controllerList);
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
                                        controller: _storeCubit
                                            .storeMainCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblMainCategory,
                                        onTap: () {
                                          advancedSearchPopUP(
                                            context: context,
                                            isMultiSelect: false,
                                            title: AppLocalizations.of(context)!
                                                .lblMainCategory,
                                            isListHaveSearch: true,
                                            listOfItem: BlocProvider.of<
                                                    CategoriesCubit>(context)
                                                .categories,
                                            onApply: (dynamic) {
                                              _storeCubit
                                                  .storeMainCategoryController
                                                  .text = dynamic.name;
                                              _storeCubit
                                                  .setSelectedCategory(dynamic);
                                              _storeCubit.isDataFount(
                                                  _storeCubit.controllerList);
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///sub category
                                      CommonTextFormField(
                                        controller: _storeCubit
                                            .storeSubCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblSubCategory,
                                        onTap: () {
                                          advancedSearchPopUP(
                                            context: context,
                                            isMultiSelect: true,
                                            multiSelectData:
                                                _storeCubit.selectedTag ?? [],
                                            title: AppLocalizations.of(context)!
                                                .lblSubCategory,
                                            isListHaveSearch: true,
                                            listOfItem:
                                                BlocProvider.of<TagsCubit>(
                                                        context)
                                                    .tagsList,
                                            onApply: (dynamic) {
                                              _storeCubit.setSelectedTags(
                                                  List.from(dynamic));
                                              _storeCubit
                                                      .storeSubCategoryController
                                                      .text =
                                                  getNameFromList(
                                                      List.from(dynamic));
                                              _storeCubit.isDataFount(
                                                  _storeCubit.controllerList);
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
                                          _storeCubit.isDataFount(
                                              _storeCubit.controllerList);
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
                                            isEnable: _storeCubit.isDataFound &&
                                                _storeCubit.imageXFile != null,
                                            isLoading: storeState
                                                is CreateStoreLoadingStates,
                                            buttonTextSize: 18,
                                            buttonTextFontWeight:
                                                FontWeight.w600,
                                            buttonText: widget
                                                    .argument.firstStoreCreate!
                                                ? AppLocalizations.of(context)!
                                                    .lblCreateStoreAndSelectPlan
                                                : AppLocalizations.of(context)!
                                                    .lblSave,
                                            onPressedFunction: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                if( widget
                                                    .argument.firstStoreCreate!) {
                                                  Navigator.of(context).pushNamed(RouteNames.planPageRoute);
                                                }else {
                                                  storeCtx
                                                    .read<StoreCubit>()
                                                    .createNewStore();
                                                }
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
