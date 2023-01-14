import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/Widgets/take_photo_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../core/presentation/Routes/route_argument_model.dart';
import '../../../core/presentation/Widgets/common_cached_image_widget.dart';
import 'logic/product_cubit.dart';

class EditProductScreen extends StatefulWidget {
  final RouteArgument argument;

  const EditProductScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late ProductCubit _productCubit;
  final formKey = GlobalKey<FormState>();


  late TextEditingController adsDetailsController;
  late TextEditingController adsMainPriceController;
  late TextEditingController adsDiscountPriceController;
  late TextEditingController adsNameController;

  late TextEditingController adsTypeController;
  late TextEditingController adsStatesController;
  late TextEditingController adsBrandController;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);

    adsNameController =
        TextEditingController(text: widget.argument.productModel!.name);
    adsDetailsController =
        TextEditingController(text: widget.argument.productModel!.description!);
    adsMainPriceController = TextEditingController(
        text: widget.argument.productModel!.price.toString());
    adsDiscountPriceController = TextEditingController(
        text: widget.argument.productModel!.price.toString());
    adsTypeController =
        TextEditingController(text: widget.argument.productModel!.type!);
    adsStatesController =
        TextEditingController(text: widget.argument.productModel!.state!);
    adsBrandController =
        TextEditingController(text: widget.argument.productModel!.brand!);
    _productCubit.isDataFound = false;
    _productCubit.controllerList.clear();

    _productCubit.controllerList.add(adsNameController);
    _productCubit.controllerList.add(adsDetailsController);
    _productCubit.controllerList.add(adsMainPriceController);
    _productCubit.controllerList.add(adsDiscountPriceController);
    _productCubit.controllerList.add(adsTypeController);
    _productCubit.controllerList.add(adsStatesController);
    _productCubit.controllerList.add(adsBrandController);
    _productCubit.isDataFount(_productCubit.controllerList);
  }

  @override
  void dispose() {

    adsNameController.dispose();
    adsDetailsController.dispose();
    adsMainPriceController.dispose();
    adsDiscountPriceController.dispose();
    adsTypeController.dispose();
    adsStatesController.dispose();
    adsBrandController.dispose();
    _productCubit.imageXFile = null;
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
                        title:
                            AppLocalizations.of(context)!.lblProductEditSuccess,
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
                                        controller: adsTypeController,
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 8),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _productCubit.imageXFile !=
                                                          null
                                                      ? commonFileImageWidget(
                                                          imageString:
                                                              _productCubit
                                                                  .imageXFile!
                                                                  .path,
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.fill)
                                                      : commonCachedImageWidget(
                                                          widget
                                                              .argument
                                                              .productModel!
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
                                                    _productCubit.imageXFile !=
                                                        null,
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
                                                productCtx.read<ProductCubit>().editProduct(
                                                    productName:
                                                        adsNameController.text,
                                                    productMainPrice:
                                                        adsMainPriceController
                                                            .text,
                                                    productDiscountPrice:
                                                        adsDiscountPriceController
                                                            .text,
                                                    productType:
                                                        adsTypeController.text,
                                                    productImage:
                                                        _productCubit.imageXFile == null
                                                            ? null
                                                            : [
                                                                _productCubit
                                                                    .imageXFile!
                                                              ],
                                                    productStates:
                                                        adsStatesController
                                                            .text,
                                                    productBrand:
                                                        adsBrandController.text,
                                                    productDescription:
                                                        adsDetailsController
                                                            .text,
                                                    storeId: widget
                                                        .argument
                                                        .productModel!
                                                        .shopModel!
                                                        .id
                                                        .toString(),
                                                    productId: widget.argument
                                                        .productModel!.id
                                                        .toString());
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
