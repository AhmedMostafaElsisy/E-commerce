import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/store_feature/presentation/logic/store_states.dart';
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
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/Widgets/take_photo_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../logic/store_cubit.dart';

class EditStoreScreen extends StatefulWidget {
  final RouteArgument argument;

  const EditStoreScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<EditStoreScreen> createState() => _EditStoreScreenState();
}

class _EditStoreScreenState extends State<EditStoreScreen> {
  late StoreCubit _storeCubit;
  final formKey = GlobalKey<FormState>();

  late TextEditingController storeNameController;
  late TextEditingController ownerNameController;
  late TextEditingController userAddressController;
  late TextEditingController userCityController;
  late TextEditingController userAreaController;
  late TextEditingController emailAddressController;

  late TextEditingController phoneNumberController;
  late TextEditingController storeMainCategoryController;
  late TextEditingController storeSubCategoryController;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    storeNameController =
        TextEditingController(text: widget.argument.shopModel!.name!);
    ownerNameController =
        TextEditingController(text: widget.argument.shopModel!.ownerName!);
    emailAddressController =
        TextEditingController(text: widget.argument.shopModel!.email!);
    phoneNumberController =
        TextEditingController(text: widget.argument.shopModel!.phone!);

    userAddressController =
        TextEditingController(text: widget.argument.shopModel!.location!);
    userCityController =
        TextEditingController(text: widget.argument.shopModel!.city!);
    userAreaController =
        TextEditingController(text: widget.argument.shopModel!.area!);
    storeMainCategoryController =
        TextEditingController(text: widget.argument.shopModel!.category!);
    storeSubCategoryController =
        TextEditingController(text: widget.argument.shopModel!.subCategory!);
    _storeCubit.isDataFound = false;
    _storeCubit.controllerList.clear();
    _storeCubit.controllerList.add(storeNameController);
    _storeCubit.controllerList.add(ownerNameController);
    _storeCubit.controllerList.add(emailAddressController);
    _storeCubit.controllerList.add(phoneNumberController);
    _storeCubit.controllerList.add(userAddressController);
    _storeCubit.controllerList.add(userCityController);
    _storeCubit.controllerList.add(userAreaController);
    _storeCubit.controllerList.add(storeMainCategoryController);
    _storeCubit.controllerList.add(storeSubCategoryController);
    _storeCubit.isDataFount(_storeCubit.controllerList);
  }

  @override
  void dispose() {
    storeNameController.dispose();
    ownerNameController.dispose();
    emailAddressController.dispose();
    phoneNumberController.dispose();
    userAddressController.dispose();
    userCityController.dispose();
    userAreaController.dispose();
    storeMainCategoryController.dispose();
    storeSubCategoryController.dispose();
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
                  textKey: AppLocalizations.of(context)!.lblEditStore,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              BlocConsumer<StoreCubit, StoreStates>(
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
                                        controller: storeNameController,
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
                                        controller: ownerNameController,
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
                                        controller: phoneNumberController,
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
                                        controller: emailAddressController,
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
                                        controller: userAddressController,
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
                                              controller: userCityController,
                                              hintKey:
                                                  AppLocalizations.of(context)!
                                                      .lblCity,
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
                                              controller: userAreaController,
                                              hintKey:
                                                  AppLocalizations.of(context)!
                                                      .lblArea,
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
                                        controller: storeMainCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblMainCategory,
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
                                        controller: storeSubCategoryController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblSubCategory,
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
                                            isEnable: _storeCubit.isDataFound,
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
                                                storeCtx.read<StoreCubit>().editStore(
                                                    storeId: widget.argument
                                                        .shopModel!.id!,
                                                    storeImage:
                                                        _storeCubit.imageXFile,
                                                    storeName:
                                                        storeNameController
                                                            .text,
                                                    ownerName:
                                                        ownerNameController
                                                            .text,
                                                    storeNumber:
                                                        phoneNumberController
                                                            .text,
                                                    storeEmail:
                                                        emailAddressController
                                                            .text,
                                                    storeAddress:
                                                        userAddressController
                                                            .text,
                                                    storeCity:
                                                        userCityController.text,
                                                    storeArea:
                                                        userAreaController.text,
                                                    storeMainCategory:
                                                        storeMainCategoryController
                                                            .text,
                                                    storeSubCategory:
                                                        storeSubCategoryController
                                                            .text);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      getSpaceHeight(AppConstants.pagePadding),
                                      CommonGlobalButton(
                                        showBorder: true,
                                        borderColor: AppConstants.lightRedColor,
                                        buttonTextSize: 18,
                                        buttonTextFontWeight: FontWeight.w600,
                                        elevation: 0,
                                        buttonBackgroundColor:
                                            AppConstants.lightWhiteColor,
                                        buttonTextColor:
                                            AppConstants.lightRedColor,
                                        buttonText:
                                            AppLocalizations.of(context)!
                                                .lblCancel,
                                        onPressedFunction: () {
                                          Navigator.of(context).pop();
                                        },
                                        height: 48,
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
