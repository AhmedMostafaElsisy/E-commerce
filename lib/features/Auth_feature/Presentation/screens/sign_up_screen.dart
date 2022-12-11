import 'dart:developer';

import 'package:captien_omda_customer/Presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_app_bar_widget.dart';
import 'package:captien_omda_customer/features/Auth_feature/Data/model/base_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../Presentation/Routes/route_names.dart';
import '../../../../Presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../Presentation/Widgets/common_file_image_widget.dart';
import '../../../../Presentation/Widgets/common_global_button.dart';
import '../../../../Presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../Presentation/Widgets/common_title_text.dart';
import '../../../../Presentation/Widgets/custom_snack_bar.dart';
import '../../../../Presentation/Widgets/take_photo_widget.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../logic/Sign_Up_Cubit/sign_up_states.dart';
import '../logic/Sign_Up_Cubit/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpCubit _signUpCubit;
  final formKey = GlobalKey<FormState>();

  late TextEditingController userNameController;
  late TextEditingController emailAddressController;

  late TextEditingController phoneNumberController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    userNameController = TextEditingController();
    emailAddressController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _signUpCubit.isDataFound = false;
    _signUpCubit.imageXFile = null;
    _signUpCubit.controllerList.clear();
    _signUpCubit.controllerList.add(userNameController);
    _signUpCubit.controllerList.add(emailAddressController);
    _signUpCubit.controllerList.add(phoneNumberController);
    _signUpCubit.controllerList.add(passwordController);
    _signUpCubit.controllerList.add(confirmPasswordController);
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailAddressController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        elevation: 0,
        withBack: true,
        showBottomIcon: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblCreateAccount,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (loginCtx, signUpState) {
          if (signUpState is UserSignUpSuccessState) {
            log("this the ${signUpState.user.data}");
            Navigator.pushReplacementNamed(
                context, RouteNames.verificationCodePageRoute,
                arguments: RouteArgument(

                    ///Todo : change this parsing
                    emailAddress: emailAddressController.text,
                    otp: UserBaseModel.fromJson(signUpState.user.data["customer"])
                        .otp!
                        .toString()));
            showSnackBar(
              context: loginCtx,
              color: AppConstants.lightOffBlueColor,
              title: AppLocalizations.of(context)!.lblSignUpSuccess,
            );
          }
          if (signUpState is UserSignUpErrorState) {
            showSnackBar(
              context: loginCtx,
              title: signUpState.error!.errorMassage!,
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SizedBox(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.pagePadding) +
                          EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          /// Upload Image
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectedPhoto(
                                    context,
                                    takePhoto: _signUpCubit.photoPicked,
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: getWidgetHeight(90),
                                      height: getWidgetHeight(90),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppConstants.backGroundColor,
                                      ),
                                      child: _signUpCubit.imageXFile != null
                                          ? commonFileImageWidget(
                                              imageString:
                                                  _signUpCubit.imageXFile!.path,
                                              height: 90,
                                              width: 90,
                                              radius: 1000,
                                              fit: BoxFit.fill)
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: commonAssetSvgImageWidget(
                                                  imageString: "camera.svg",
                                                  height: 32,
                                                  width: 32,
                                                  fit: BoxFit.contain,
                                                  imageColor:
                                                      AppConstants.mainColor),
                                            ),
                                    ),
                                    _signUpCubit.imageXFile == null
                                        ? const SizedBox()
                                        : Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: InkWell(
                                              onTap: () {
                                                _signUpCubit
                                                    .clearSelectedImage();
                                              },
                                              child: Container(
                                                height: getWidgetHeight(24),
                                                width: getWidgetWidth(24),
                                                decoration: const BoxDecoration(
                                                    color:
                                                        AppConstants.mainColor,
                                                    shape: BoxShape.circle),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child:
                                                      commonAssetSvgImageWidget(
                                                          imageString:
                                                              "bin_icon.svg",
                                                          height: 12,
                                                          imageColor: AppConstants
                                                              .lightWhiteColor,
                                                          width: 12),
                                                ),
                                              ),
                                            ))
                                  ],
                                ),
                              ),
                            ],
                          ),

                          ///spacer
                          getSpaceHeight(AppConstants.pagePadding),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                /// User Name
                                CommonTextFormField(
                                  radius: AppConstants.smallBorderRadius,
                                  controller: userNameController,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterName,
                                  labelText:
                                      AppLocalizations.of(context)!.lblName,
                                  keyboardType: TextInputType.text,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  withSuffixIcon: true,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "person_icon.svg",
                                        fit: BoxFit.contain,
                                        height: 22,
                                        width: 22),
                                  ),
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
                                    _signUpCubit.isDataFount(
                                        _signUpCubit.controllerList);
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.pagePadding),

                                /// Email
                                CommonTextFormField(
                                  radius: AppConstants.smallBorderRadius,
                                  controller: emailAddressController,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterEmail,
                                  labelText:
                                      AppLocalizations.of(context)!.lblEmail,
                                  keyboardType: TextInputType.text,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  withSuffixIcon: true,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "email_icon.svg",
                                        fit: BoxFit.contain,
                                        height: 22,
                                        width: 22),
                                  ),
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      if (!validateEmail(value)) {
                                        return AppLocalizations.of(context)!
                                            .lblEmailBadFormat;
                                      } else {
                                        return null;
                                      }
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    _signUpCubit.isDataFount(
                                        _signUpCubit.controllerList);
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.pagePadding),

                                /// Phone
                                CommonTextFormField(
                                  controller: phoneNumberController,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterPhoneNumber,
                                  labelText:
                                      AppLocalizations.of(context)!.lblPhone,
                                  keyboardType: TextInputType.phone,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  withSuffixIcon: true,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "phone_icon.svg",
                                        fit: BoxFit.contain,
                                        height: 22,
                                        width: 22),
                                  ),
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
                                    _signUpCubit.isDataFount(
                                        _signUpCubit.controllerList);
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.pagePadding),

                                /// Password
                                CommonTextFormField(
                                  controller: passwordController,
                                  withSuffixIcon: true,
                                  withPrefixIcon: true,
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      _signUpCubit.switchPasswordToggle();
                                    },
                                    child: SizedBox(
                                      width: getWidgetWidth(30),
                                      height: getWidgetHeight(30),
                                      child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            child: commonAssetSvgImageWidget(
                                                imageString:
                                                    _signUpCubit.hidePassword
                                                        ? "eye_open.svg"
                                                        : "eye_close.svg",
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.contain)),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText: _signUpCubit.hidePassword,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterComplexPassword,
                                  labelText:
                                      AppLocalizations.of(context)!.lblPassword,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "lock_icon.svg",
                                        fit: BoxFit.contain,
                                        height: 22,
                                        width: 22),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordIsEmpty;
                                    } else if (value.length < 8) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordMustBeMoreThan;
                                    } else if (complexValidationLowerAndUpperCaseValidator(
                                        value)) {
                                      return AppLocalizations.of(context)!
                                          .lblComplexPasswordValidationUpperAndLower;
                                    } else if (complexValidationSpecialCharactersValidator(
                                        value)) {
                                      return AppLocalizations.of(context)!
                                          .lblComplexPasswordValidationSc;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    _signUpCubit.isDataFount(
                                        _signUpCubit.controllerList);
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.pagePadding),

                                /// Confirm Password
                                CommonTextFormField(
                                  controller: confirmPasswordController,
                                  withSuffixIcon: true,
                                  withPrefixIcon: true,
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      _signUpCubit.switchPasswordToggle(
                                          isMainPassword: false);
                                    },
                                    child: SizedBox(
                                      width: getWidgetWidth(30),
                                      height: getWidgetHeight(30),
                                      child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            child: commonAssetSvgImageWidget(
                                                imageString: _signUpCubit
                                                        .hideConfirmPassword
                                                    ? "eye_open.svg"
                                                    : "eye_close.svg",
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.contain)),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText:
                                      _signUpCubit.hideConfirmPassword,
                                  radius: AppConstants.smallBorderRadius,
                                  labelText:
                                      AppLocalizations.of(context)!.lblPassword,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblConfirmPassword,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "lock_icon.svg",
                                        fit: BoxFit.contain,
                                        height: 22,
                                        width: 22),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordIsEmpty;
                                    } else if (value.length < 8) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordMustBeMoreThan;
                                    } else if (value !=
                                        passwordController.text) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordDontMatch;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    _signUpCubit.isDataFount(
                                        _signUpCubit.controllerList);
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(
                                    AppConstants.pagePaddingDouble * 2),

                                /// Create Account Button
                                CommonGlobalButton(
                                    height: 48,
                                    buttonBackgroundColor:
                                        AppConstants.mainColor,
                                    isEnable: _signUpCubit.isDataFound,
                                    isLoading: state is UserSignUpLoadingState,
                                    radius: AppConstants.smallBorderRadius,
                                    buttonTextSize: 18,
                                    buttonTextFontWeight: FontWeight.w400,
                                    buttonText: AppLocalizations.of(context)!
                                        .lblCreateAccount,
                                    onPressedFunction: () {
                                      if (formKey.currentState!.validate()) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _signUpCubit.singUp(
                                            email: emailAddressController.text,
                                            password: passwordController.text,
                                            confirmPassword:
                                                confirmPasswordController.text,
                                            phone: phoneNumberController.text,
                                            username: userNameController.text,
                                            token: SharedText.deviceToken);
                                      }
                                    },
                                    withIcon: false),

                                ///spacer
                                getSpaceHeight(AppConstants.pagePaddingDouble),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
