
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/features/edit_product_feature/presentation/widget/product_image_picked.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_names.dart';
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
import '../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../core/presentation/Widgets/select_item_pop_up.dart';
import '../../../core/presentation/search_filter_cubit/search_filet_cubit.dart';
import '../../Categories_feature/presentation/logic/category_cubit.dart';
import 'logic/edit_product/edit_product_cubit.dart';
import 'logic/edit_product/edit_product_states.dart';

class EditProductScreen extends StatefulWidget {
  final RouteArgument argument;

  const EditProductScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late EditProductCubit _productCubit;
  final formKey = GlobalKey<FormState>();

  late FormBuilderCubit formBuilderCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<EditProductCubit>(context);

    formBuilderCubit = BlocProvider.of<FormBuilderCubit>(context);

    _productCubit.isDataFound = false;
    _productCubit.controllerList.clear();

    _productCubit.getMyAdsEditDetails(widget.argument.productModel!.id!);
    AllFilterCubit.get(context).clearAll();
  }

  @override
  void dispose() {
    _productCubit.adsNameController.dispose();
    _productCubit.adsDetailsController.dispose();
    _productCubit.adsMainPriceController.dispose();
    _productCubit.adsDiscountPriceController.dispose();
    _productCubit.adsTypeController.dispose();
    _productCubit.adsStatesController.dispose();
    _productCubit.adsBrandController.dispose();
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
                  textKey: AppLocalizations.of(context)!.lblEditAds,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              BlocConsumer<EditProductCubit, EditProductState>(
                listener: (productCtx, productState) {
                  if (productState is EditProductFailState) {
                    checkUserAuth(
                        context: productCtx,
                        errorType: productState.error.type);
                    showSnackBar(
                      context: productCtx,
                      title: productState.error.errorMassage!,
                    );
                  } else if (productState is EditProductSuccessState) {
                    showSnackBar(
                        context: productCtx,
                        title:
                            AppLocalizations.of(context)!.lblProductEditSuccess,
                        color: AppConstants.successColor);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.mainBottomNavPageRoute,
                      (route) => false,
                    );
                  } else if (productState
                      is GetEditProductDetailsEditSuccessState) {
                    formBuilderCubit.formList = productCtx
                        .read<EditProductCubit>()
                        .selectedProduct
                        .formList!;

                    formBuilderCubit.updateView();
                  }
                },
                builder: (productCtx, productState) {
                  if (productState is GetEditProductDetailsEditLoadingState) {
                    return const Center(child: CommonLoadingWidget());
                  } else if (productState
                      is GetEditProductDetailsEditFailedState) {
                    return CommonError(
                        errorMassage: productState.error.errorMassage,
                        withButton: true,
                        onTap: () {
                          _productCubit.getMyAdsEditDetails(
                              widget.argument.productModel!.id!);
                        });
                  } else {
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
                                          controller:
                                              _productCubit.adsNameController,
                                          hintKey: AppLocalizations.of(context)!
                                              .lblAdsName,
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
                                            _productCubit.isDataFount(
                                                _productCubit.controllerList);
                                            return null;
                                          },
                                        ),

                                        ///spacer
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///ads price
                                        Row(
                                          children: [
                                            ///main price
                                            Expanded(
                                              child: CommonTextFormField(
                                                controller: _productCubit
                                                    .adsMainPriceController,
                                                hintKey: AppLocalizations.of(
                                                        context)!
                                                    .lblAdsPrice,
                                                keyboardType:
                                                    TextInputType.phone,
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
                                                  }else if (int.parse(value) <=
                                                      int.parse(
                                                          _productCubit.    adsDiscountPriceController
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
                                                controller: _productCubit
                                                    .adsDiscountPriceController,
                                                hintKey: AppLocalizations.of(
                                                        context)!
                                                    .lblAdsPriceAfterDiscount,
                                                keyboardType:
                                                    TextInputType.phone,
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
                                                  }else if (int.parse(value) >=
                                                      int.parse(
                                                          _productCubit.  adsMainPriceController
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
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///ads type
                                        CommonTextFormField(
                                          controller:
                                              _productCubit.adsTypeController,
                                          hintKey: AppLocalizations.of(context)!
                                              .lblAdsType,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblNameIsEmpty;
                                            } else if (nameValidator(value)) {
                                              return AppLocalizations.of(
                                                      context)!
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
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///shop logo
                                        InkWell(
                                          onTap: () {
                                            takePhotoBottomSheet(
                                                context: context,
                                                getPhoto: productCtx
                                                    .read<EditProductCubit>()
                                                    .photoPicked);
                                          },
                                          child: Container(
                                            width: SharedText.screenWidth,
                                            height: getWidgetHeight(48),
                                            decoration: BoxDecoration(
                                              color:
                                                  AppConstants.lightWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: AppConstants
                                                      .lightGrayColor,
                                                  width: 1),
                                            ),
                                            child:  Padding(
                                              padding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8),
                                              child: ProductImagePicked(),
                                            ),
                                          ),
                                        ),

                                        ///spacer
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///states
                                        CommonTextFormField(
                                          controller:
                                              _productCubit.adsStatesController,
                                          hintKey: AppLocalizations.of(context)!
                                              .lblStates,
                                          keyboardType: TextInputType.text,
                                          labelHintColor:
                                              AppConstants.mainColor,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .lblNameIsEmpty;
                                            } else if (nameValidator(value)) {
                                              return AppLocalizations.of(
                                                      context)!
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
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///brand
                                        CommonTextFormField(
                                          controller:
                                              _productCubit.adsBrandController,
                                          hintKey: AppLocalizations.of(context)!
                                              .lblBrand,
                                          onTap: () {
                                            advancedSearchPopUP(
                                              context: context,
                                              isMultiSelect: false,
                                              preSelectedData: _productCubit
                                                  .selectedCategory!,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .lblMainCategory,
                                              isListHaveSearch: true,
                                              listOfItem: BlocProvider.of<
                                                      CategoriesCubit>(context)
                                                  .categories,
                                              onApply: (dynamic) {
                                                _productCubit.adsBrandController
                                                    .text = dynamic.name;
                                                _productCubit
                                                    .setSelectedCategory(
                                                        dynamic);
                                                _productCubit.isDataFount(
                                                    _productCubit
                                                        .controllerList);
                                              },
                                            );
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
                                            } else if (nameValidator(value)) {
                                              return AppLocalizations.of(
                                                      context)!
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
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///ads details
                                        CommonTextFormField(
                                          minLines: 3,
                                          maxLines: 5,
                                          controller: _productCubit
                                              .adsDetailsController,
                                          hintKey: AppLocalizations.of(context)!
                                              .lblAdsDetails,
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
                                            _productCubit.isDataFount(
                                                _productCubit.controllerList);
                                            return null;
                                          },
                                        ),

                                        ///spacer
                                        getSpaceHeight(
                                            AppConstants.smallPadding),

                                        ///select items
                                        FormDataScreen(
                                          categoryId: _productCubit
                                              .selectedCategory!.id,
                                        ),

                                        ///spacer
                                        getSpaceHeight(
                                            AppConstants.smallPadding),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CommonGlobalButton(
                                              height: 48,
                                              buttonBackgroundColor:
                                                  AppConstants.mainColor,
                                              isEnable:
                                                  _productCubit.isDataFound && _productCubit.selectedProduct.images!.isNotEmpty,
                                              isLoading: productState
                                                  is EditProductLoadingState,
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
                                                      .requestFocus(
                                                          FocusNode());
                                                  productCtx
                                                      .read<EditProductCubit>()
                                                      .editProduct();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            )));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
