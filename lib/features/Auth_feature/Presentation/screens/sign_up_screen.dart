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
  bool acceptTerms = false;
  final formKey = GlobalKey<FormState>();

  late TextEditingController userNameController;
  late TextEditingController emailAddressController;

  late TextEditingController phoneNumberController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  List<TextEditingController> controllerList = [];
  late bool isDataFound;

  @override
  void initState() {
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    userNameController = TextEditingController();
    emailAddressController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    isDataFound = false;
    _signUpCubit.imageXFile = null;
    controllerList.add(userNameController);
    controllerList.add(emailAddressController);
    controllerList.add(phoneNumberController);
    controllerList.add(passwordController);
    controllerList.add(confirmPasswordController);
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
      body: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (loginCtx, signUpState) {
          if (signUpState is UserSignUpSuccessState) {
            Navigator.pushReplacementNamed(
                context, RouteNames.loginHomePageRoute);
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
                  getSpaceHeight(75),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pagePadding),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          /// Title
                          Row(
                            children: [
                              CommonTitleText(
                                textKey:
                                    AppLocalizations.of(context)!.lblSignup,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: AppConstants.normalFontSize,
                                textWeight: FontWeight.w700,
                              ),
                            ],
                          ),

                          getSpaceHeight(16),

                          /// Upload Image
                          Row(
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
                                      width: getWidgetWidth(46),
                                      height: getWidgetHeight(46),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppConstants.smallRadius),
                                          color: AppConstants.lightWhiteColor,
                                          border: Border.all(
                                              color: _signUpCubit.imageXFile !=
                                                      null
                                                  ? AppConstants.lightWhiteColor
                                                  : AppConstants
                                                      .mainTextColor)),
                                      child: _signUpCubit.imageXFile != null
                                          ? commonFileImageWidget(
                                              imageString:
                                                  _signUpCubit.imageXFile!.path,
                                              height: 47,
                                              width: 47,
                                              radius: 4,
                                              fit: BoxFit.fill)
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: commonAssetSvgImageWidget(
                                                imageString: "person_icon.svg",
                                                height: 22,
                                                width: 22,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                    _signUpCubit.imageXFile != null
                                        ? const SizedBox()
                                        : Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: commonAssetSvgImageWidget(
                                                imageString: "add_icon.svg",
                                                height: 10.3,
                                                width: 10.3))
                                  ],
                                ),
                              ),
                              getSpaceWidth(6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_signUpCubit.imageXFile != null) ...[
                                    Material(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _signUpCubit.imageXFile = null;
                                          });
                                        },
                                        child: CommonTitleText(
                                          textKey: AppLocalizations.of(context)!
                                              .lblRemoveImage,
                                          textColor: AppConstants.mainColor,
                                          textFontSize:
                                              AppConstants.normalFontSize,
                                          textWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblAddProfilePicture,
                                      textColor: AppConstants.mainTextColor,
                                      textFontSize: 14,
                                      textWeight: FontWeight.w400,
                                    ),
                                    CommonTitleText(
                                      textKey:
                                          "(${AppLocalizations.of(context)!.lblOptional})",
                                      textColor: AppConstants.mainTextColor,
                                      textFontSize: 14,
                                      textWeight: FontWeight.w400,
                                    ),
                                  ]
                                ],
                              )
                            ],
                          ),

                          getSpaceHeight(16),

                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                /// User Name
                                CommonTextFormField(
                                  radius: AppConstants.smallBorderRadius,
                                  controller: userNameController,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblName,
                                  keyboardType: TextInputType.text,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  borderColor: AppConstants.borderInputColor,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "person_icon.svg",
                                        fit: BoxFit.fill,
                                        height: 16,
                                        width: 16),
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
                                    isDataFount(controllerList);
                                    return null;
                                  },
                                ),

                                getSpaceHeight(16),

                                /// Email
                                CommonTextFormField(
                                  controller: emailAddressController,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  borderColor: AppConstants.borderInputColor,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 17, horizontal: 12),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "email_icon.svg",
                                        fit: BoxFit.fill,
                                        height: 16,
                                        width: 16),
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
                                    isDataFount(controllerList);
                                    return null;
                                  },
                                ),

                                getSpaceHeight(16),

                                /// Phone
                                CommonTextFormField(
                                  controller: phoneNumberController,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblPhone,
                                  keyboardType: TextInputType.phone,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  borderColor: AppConstants.borderInputColor,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 15),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "phone_icon.svg",
                                        fit: BoxFit.fill,
                                        height: 16,
                                        width: 16),
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
                                    isDataFount(controllerList);
                                    return null;
                                  },
                                ),

                                getSpaceHeight(16),

                                /// Password
                                CommonTextFormField(
                                  controller: passwordController,
                                  withSuffixIcon: true,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: hidePassword
                                          ? commonAssetSvgImageWidget(
                                              imageString: "eye_open.svg",
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.fill)
                                          : commonAssetSvgImageWidget(
                                              imageString: "eye_close.svg",
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.fill),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText: hidePassword,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterComplexPassword,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  borderColor: AppConstants.borderInputColor,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 15),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "lock_icon.svg",
                                        fit: BoxFit.fill,
                                        height: 16,
                                        width: 16),
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
                                    isDataFount(controllerList);
                                    return null;
                                  },
                                ),

                                getSpaceHeight(16),

                                /// Confirm Password
                                CommonTextFormField(
                                  controller: confirmPasswordController,
                                  withSuffixIcon: true,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hideConfirmPassword =
                                            !hideConfirmPassword;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: hideConfirmPassword
                                          ? commonAssetSvgImageWidget(
                                              imageString: "eye_open.svg",
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.fill)
                                          : commonAssetSvgImageWidget(
                                              imageString: "eye_close.svg",
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.fill),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText: hideConfirmPassword,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblRetypePassword,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  borderColor: AppConstants.borderInputColor,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 15),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "lock_icon.svg",
                                        fit: BoxFit.fill,
                                        height: 16,
                                        width: 16),
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
                                    isDataFount(controllerList);
                                    return null;
                                  },
                                ),

                                getSpaceHeight(16),

                                /// Terms And Conditions
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          acceptTerms = !acceptTerms;
                                        });
                                      },
                                      child: Container(
                                        width: getWidgetWidth(24),
                                        height: getWidgetHeight(24),
                                        decoration: BoxDecoration(
                                            color: acceptTerms
                                                ? AppConstants.mainColor
                                                : AppConstants.lightWhiteColor,
                                            borderRadius: BorderRadius.circular(
                                                AppConstants.smallBorderRadius),
                                            border: Border.all(
                                                color: acceptTerms
                                                    ? AppConstants.mainColor
                                                    : AppConstants
                                                        .borderInputColor,
                                                width: 1)),
                                        child: const Icon(
                                          Icons.check,
                                          color: AppConstants.lightWhiteColor,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    getSpaceWidth(4),
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblAccept,
                                      textColor: AppConstants.mainTextColor,
                                      textFontSize: 12,
                                      textWeight: FontWeight.w700,
                                    ),
                                    getSpaceWidth(2),
                                    GestureDetector(
                                      onTap: () {},
                                      child: CommonTitleText(
                                        textKey: AppLocalizations.of(context)!
                                            .lblOutTermsAndConditions,
                                        textColor: AppConstants.mainColor,
                                        textFontSize: 12,
                                        textWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),

                                getSpaceHeight(32),

                                /// Create Account Button
                                CommonGlobalButton(
                                    height: 48,
                                    buttonBackgroundColor:
                                        AppConstants.mainColor,
                                    isEnable: isDataFound && acceptTerms,
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
                                        if (acceptTerms) {
                                          _signUpCubit.singUp(
                                              email:
                                                  emailAddressController.text,
                                              password: passwordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text,
                                              phone: phoneNumberController.text,
                                              username: userNameController.text,
                                              token: SharedText.deviceToken);
                                        } else {
                                          showSnackBar(
                                            context: context,
                                            title: AppLocalizations.of(context)!
                                                .lblPleaseConfirmOnTerms,
                                          );
                                        }
                                      }
                                    },
                                    withIcon: false),

                                getSpaceHeight(20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblHaveAccount,
                                      textColor: AppConstants.lightBlackColor,
                                      textFontSize: 13,
                                      textWeight: FontWeight.w400,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(context,
                                            RouteNames.loginHomePageRoute);
                                      },
                                      child: CommonTitleText(
                                        textKey: AppLocalizations.of(context)!
                                            .lblLogin,
                                        textColor: AppConstants.lightBlackColor,
                                        textFontSize: 14,
                                        textWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
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

  void isDataFount(List<TextEditingController> list) {
    setState(() {
      isDataFound = true;
    });

    for (var element in list) {
      if (element.text.isEmpty) {
        setState(() {
          isDataFound = false;
        });

        return;
      }
    }
  }
}
