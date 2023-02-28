import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_states.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_image_picked.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/Widgets/take_photo_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../core/form_builder_feature/presentation/form_data_screen.dart';
import '../../../core/form_builder_feature/presentation/logic/form_builder_cubit.dart';
import '../../../core/presentation/Routes/route_argument_model.dart';
import '../../../core/presentation/Routes/route_names.dart';
import '../../../core/presentation/Widgets/select_item_pop_up.dart';
import '../../../core/presentation/search_filter_cubit/search_filet_cubit.dart';
import '../../Categories_feature/presentation/logic/category_cubit.dart';
import 'logic/product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  final RouteArgument argument;

  const AddProductScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late ProductCubit _productCubit;
  final formKey = GlobalKey<FormState>();

  late TextEditingController adsDetailsController;
  late TextEditingController adsMainPriceController;
  late TextEditingController adsDiscountPriceController;
  late TextEditingController adsNameController;

  late TextEditingController storeMainCategoryController;
  late TextEditingController adsStatesController;
  late TextEditingController adsBrandController;
  late FormBuilderCubit formBuilderCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);

    adsNameController = TextEditingController();

    adsDetailsController = TextEditingController();
    adsMainPriceController = TextEditingController();
    adsDiscountPriceController = TextEditingController();
    storeMainCategoryController = TextEditingController();
    adsStatesController = TextEditingController();
    adsBrandController = TextEditingController();
    _productCubit.isDataFound = false;
    _productCubit.controllerList.clear();
    formBuilderCubit = BlocProvider.of<FormBuilderCubit>(context);
    formBuilderCubit.formList.clear();
    _productCubit.controllerList.add(adsNameController);
    _productCubit.controllerList.add(adsDetailsController);
    _productCubit.controllerList.add(adsMainPriceController);
    _productCubit.controllerList.add(adsDiscountPriceController);
    _productCubit.controllerList.add(storeMainCategoryController);
    _productCubit.controllerList.add(adsStatesController);
    _productCubit.controllerList.add(adsBrandController);
  }

  @override
  void dispose() {
    adsNameController.dispose();
    adsDetailsController.dispose();
    adsMainPriceController.dispose();
    adsDiscountPriceController.dispose();
    storeMainCategoryController.dispose();
    adsStatesController.dispose();
    adsBrandController.dispose();
    _productCubit.imageXFile = [];
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
                  textKey: AppLocalizations.of(context)!.lblAddProduct,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (productCtx, productState) {
                  if (productState is AddNewProductErrorState) {
                    checkUserAuth(
                        context: productCtx,
                        errorType: productState.error.type);
                    showSnackBar(
                      context: productCtx,
                      title: productState.error.errorMassage!,
                    );
                  } else if (productState is AddNewProductSuccessState) {
                    showSnackBar(
                        context: productCtx,
                        title: AppLocalizations.of(context)!
                            .lblProductCreatedSuccess,
                        color: AppConstants.successColor);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.mainBottomNavPageRoute,
                      (route) => false,
                    );
                  }
                },
                builder: (productCtx, productState) {
                  return Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.pagePadding) +
                              EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: [
                              Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      /// ads name
                                      CommonTextFormField(
                                        controller: adsNameController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblAdsName,
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
                                          _productCubit.isDataFount(
                                              _productCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///ads price
                                      Row(
                                        children: [
                                          ///main price
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller:
                                                  adsMainPriceController,
                                              hintKey:
                                                  AppLocalizations.of(context)!
                                                      .lblAdsPrice,
                                              keyboardType: TextInputType.phone,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              inputFormatter: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .lblNameIsEmpty;
                                                } else if (int.parse(value) <=
                                                    int.parse(
                                                        adsDiscountPriceController
                                                            .text)) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .lblNoValid;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _productCubit.isDataFount(
                                                    _productCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),

                                          ///Spacer
                                          getSpaceWidth(
                                              AppConstants.smallPadding),

                                          ///discount price
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller:
                                                  adsDiscountPriceController,
                                              hintKey:
                                                  AppLocalizations.of(context)!
                                                      .lblAdsPriceAfterDiscount,
                                              keyboardType: TextInputType.phone,
                                              labelHintColor:
                                                  AppConstants.mainColor,
                                              inputFormatter: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .lblNameIsEmpty;
                                                } else if (int.parse(value) >=
                                                    int.parse(
                                                        adsMainPriceController
                                                            .text)) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .lblNoValid;
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (value) {
                                                _productCubit.isDataFount(
                                                    _productCubit
                                                        .controllerList);
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///ads type
                                      CommonTextFormField(
                                        controller: storeMainCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblAdsType,
                                        keyboardType: TextInputType.text,
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
                                          _productCubit.isDataFount(
                                              _productCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///shop logo
                                      InkWell(
                                        onTap: () {
                                          takePhotoBottomSheet(
                                              context: context,
                                              getPhoto: productCtx
                                                  .read<ProductCubit>()
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
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 8),
                                            child: ProductNewImagePicked(),
                                          ),
                                        ),
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///states
                                      CommonTextFormField(
                                        controller: adsStatesController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblStates,
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
                                          _productCubit.isDataFount(
                                              _productCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///brand
                                      CommonTextFormField(
                                        controller: adsBrandController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblBrand,
                                        onTap: () {
                                          advancedSearchPopUP(
                                            context: context,
                                            isMultiSelect: false,
                                            title: AppLocalizations.of(context)!
                                                .lblMainCategory,
                                            preSelectedData:
                                                _productCubit.selectedCategory,
                                            isListHaveSearch: true,
                                            listOfItem: BlocProvider.of<
                                                    CategoriesCubit>(context)
                                                .categories,
                                            onApply: (dynamic) {
                                              adsBrandController.text =
                                                  dynamic.name;
                                              _productCubit
                                                  .setSelectedCategory(dynamic);
                                              _productCubit.isDataFount(
                                                  _productCubit.controllerList);
                                              AllFilterCubit.get(context)
                                                  .clearAll();

                                              formBuilderCubit.getProductForm(
                                                  categoryId: dynamic.id!);
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
                                          _productCubit.isDataFount(
                                              _productCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///Spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///ads details
                                      CommonTextFormField(
                                        minLines: 3,
                                        maxLines: 5,
                                        controller: adsDetailsController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblAdsDetails,
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
                                          _productCubit.isDataFount(
                                              _productCubit.controllerList);
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///select items
                                      FormDataScreen(
                                        categoryId:
                                            _productCubit.selectedCategory ==
                                                    null
                                                ? null
                                                : _productCubit
                                                    .selectedCategory!.id,
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
                                                _productCubit.isDataFound &&
                                                    _productCubit
                                                        .imageXFile.isNotEmpty,
                                            isLoading: productState
                                                is AddNewProductLoadingState,
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

                                                productCtx.read<ProductCubit>().addNewProduct(
                                                    formData: formBuilderCubit
                                                        .formList,
                                                    productName:
                                                        adsNameController.text,
                                                    productMainPrice:
                                                        adsMainPriceController
                                                            .text,
                                                    productDiscountPrice:
                                                        adsDiscountPriceController
                                                            .text,
                                                    productType:
                                                        storeMainCategoryController
                                                            .text,
                                                    productImage: _productCubit
                                                        .imageXFile,
                                                    productStates:
                                                        adsStatesController
                                                            .text,
                                                    productBrand: _productCubit
                                                        .selectedCategory!.id
                                                        .toString(),
                                                    productDescription:
                                                        adsDetailsController
                                                            .text,
                                                    shopModel: widget
                                                        .argument.shopModel!);
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
}
