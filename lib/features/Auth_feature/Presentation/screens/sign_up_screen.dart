import 'package:captien_omda_customer/features/Auth_feature/Presentation/screens/widget/scoial_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
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

  late TextEditingController userFirstNameController;
  late TextEditingController userLastNameController;
  late TextEditingController userAddressController;
  late TextEditingController userCityController;
  late TextEditingController userAreaController;
  late TextEditingController emailAddressController;

  late TextEditingController phoneNumberController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    userFirstNameController = TextEditingController();
    userLastNameController = TextEditingController();
    emailAddressController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userAddressController = TextEditingController();
    userCityController = TextEditingController();
    userAreaController = TextEditingController();
    _signUpCubit.isDataFound = false;
    _signUpCubit.controllerList.clear();
    _signUpCubit.controllerList.add(userFirstNameController);
    _signUpCubit.controllerList.add(userLastNameController);
    _signUpCubit.controllerList.add(emailAddressController);
    _signUpCubit.controllerList.add(phoneNumberController);
    _signUpCubit.controllerList.add(passwordController);
    _signUpCubit.controllerList.add(confirmPasswordController);
    _signUpCubit.controllerList.add(userAddressController);
    _signUpCubit.controllerList.add(userCityController);
    _signUpCubit.controllerList.add(userAreaController);
  }

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    emailAddressController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userAddressController.dispose();
    userCityController.dispose();
    userAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (loginCtx, signUpState) {
          if (signUpState is UserSignUpSuccessState) {
            Navigator.pushReplacementNamed(
                context, RouteNames.verificationCodePageRoute,
                arguments: RouteArgument(
                    emailAddress: emailAddressController.text,
                    otp: signUpState.otp));
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
        builder: (signUpCtx, signUpstate) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(signUpCtx).requestFocus(FocusNode());
            },
            child: MainAppPage(
              screenContent: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///spacer
                      getSpaceHeight(60),

                      ///app logo
                      commonAssetImageWidget(
                        imageString: "side_logo.png",
                        height: 48,
                        width: 130,
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.pagePaddingDouble),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.pagePadding) +
                              EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(signUpCtx).viewInsets.bottom,
                              ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    /// User Name
                                    Row(
                                      children: [
                                        ///First name
                                        Expanded(
                                          child: CommonTextFormField(
                                            controller: userFirstNameController,
                                            hintKey:
                                                AppLocalizations.of(signUpCtx)!
                                                    .lblFirstName,
                                            keyboardType: TextInputType.text,
                                            labelHintStyle:
                                                AppConstants.mainColor,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
                                                    .lblNameIsEmpty;
                                              } else if (nameValidator(value)) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
                                                    .lblNameBadFormat;
                                              } else if (value.length < 2) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
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
                                        ),

                                        ///Spacer
                                        getSpaceWidth(
                                            AppConstants.smallPadding),

                                        ///last name
                                        Expanded(
                                          child: CommonTextFormField(
                                            controller: userLastNameController,
                                            hintKey:
                                                AppLocalizations.of(signUpCtx)!
                                                    .lblLastName,
                                            keyboardType: TextInputType.text,
                                            labelHintStyle:
                                                AppConstants.mainColor,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
                                                    .lblNameIsEmpty;
                                              } else if (nameValidator(value)) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
                                                    .lblNameBadFormat;
                                              } else if (value.length < 2) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
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
                                        ),
                                      ],
                                    ),

                                    ///spacer
                                    getSpaceHeight(AppConstants.smallPadding),

                                    /// Email
                                    CommonTextFormField(
                                      controller: emailAddressController,
                                      hintKey: AppLocalizations.of(signUpCtx)!
                                          .lblEmail,
                                      keyboardType: TextInputType.text,
                                      labelHintStyle: AppConstants.mainColor,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          if (!validateEmail(value)) {
                                            return AppLocalizations.of(
                                                    signUpCtx)!
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
                                    getSpaceHeight(AppConstants.smallPadding),

                                    /// Phone
                                    CommonTextFormField(
                                      controller: phoneNumberController,
                                      hintKey: AppLocalizations.of(signUpCtx)!
                                          .lblPhone,
                                      keyboardType: TextInputType.phone,
                                      labelHintStyle: AppConstants.mainColor,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblPhoneIsEmpty;
                                        } else if (value.length <
                                            AppConstants.phoneLength) {
                                          return AppLocalizations.of(signUpCtx)!
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
                                    getSpaceHeight(AppConstants.smallPadding),

                                    /// Password
                                    CommonTextFormField(
                                      controller: passwordController,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 15),
                                                child: CommonAssetSvgImageWidget(
                                                    imageString: _signUpCubit
                                                            .hidePassword
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
                                      hintKey: AppLocalizations.of(signUpCtx)!
                                          .lblPassword,
                                      labelHintStyle: AppConstants.mainColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblPasswordIsEmpty;
                                        } else if (value.length < 8) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblPasswordMustBeMoreThan;
                                        } else if (complexValidationLowerAndUpperCaseValidator(
                                            value)) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblComplexPasswordValidationUpperAndLower;
                                        } else if (complexValidationSpecialCharactersValidator(
                                            value)) {
                                          return AppLocalizations.of(signUpCtx)!
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
                                    getSpaceHeight(AppConstants.smallPadding),

                                    /// Confirm Password
                                    CommonTextFormField(
                                      controller: confirmPasswordController,
                                      keyboardType: TextInputType.text,
                                      minLines: 1,
                                      maxLines: 1,
                                      isObscureText: true,
                                      labelText: AppLocalizations.of(signUpCtx)!
                                          .lblPassword,
                                      hintKey: AppLocalizations.of(signUpCtx)!
                                          .lblConfirmPassword,
                                      labelHintStyle: AppConstants.mainColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblPasswordIsEmpty;
                                        } else if (value.length < 8) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblPasswordMustBeMoreThan;
                                        } else if (value !=
                                            passwordController.text) {
                                          return AppLocalizations.of(signUpCtx)!
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
                                    getSpaceHeight(AppConstants.smallPadding),

                                    ///address
                                    CommonTextFormField(
                                      fieldHeight: 64,
                                      minLines: 4,
                                      maxLines: 20,
                                      controller: userAddressController,
                                      hintKey: AppLocalizations.of(signUpCtx)!
                                          .lblAddressDetails,
                                      labelText: AppLocalizations.of(signUpCtx)!
                                          .lblName,
                                      keyboardType: TextInputType.text,
                                      labelHintStyle: AppConstants.mainColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(signUpCtx)!
                                              .lblNameIsEmpty;
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
                                    getSpaceHeight(AppConstants.smallPadding),

                                    ///area and city
                                    Row(
                                      children: [
                                        ///City
                                        Expanded(
                                          child: CommonTextFormField(
                                            controller: userCityController,
                                            hintKey:
                                                AppLocalizations.of(signUpCtx)!
                                                    .lblCity,
                                            keyboardType: TextInputType.text,
                                            labelHintStyle:
                                                AppConstants.mainColor,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
                                                    .lblNameIsEmpty;
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
                                        ),

                                        ///Spacer
                                        getSpaceWidth(
                                            AppConstants.smallPadding),

                                        ///Area
                                        Expanded(
                                          child: CommonTextFormField(
                                            controller: userAreaController,
                                            hintKey:
                                                AppLocalizations.of(signUpCtx)!
                                                    .lblArea,
                                            keyboardType: TextInputType.text,
                                            labelHintStyle:
                                                AppConstants.mainColor,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        signUpCtx)!
                                                    .lblNameIsEmpty;
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
                                        ),
                                      ],
                                    ),

                                    ///spacer
                                    getSpaceHeight(AppConstants.smallPadding),

                                    /// Create Account Button
                                    CommonGlobalButton(
                                      height: 48,
                                      buttonBackgroundColor:
                                          AppConstants.mainColor,
                                      isEnable: _signUpCubit.isDataFound,
                                      isLoading:
                                          signUpstate is UserSignUpLoadingState,
                                      buttonTextSize: 18,
                                      buttonTextFontWeight: FontWeight.w400,
                                      buttonText:
                                          AppLocalizations.of(signUpCtx)!
                                              .lblCreateAccount,
                                      onPressedFunction: () {
                                        if (formKey.currentState!.validate()) {
                                          FocusScope.of(signUpCtx)
                                              .requestFocus(FocusNode());
                                          _signUpCubit.singUp(
                                              email:
                                                  emailAddressController.text,
                                              password: passwordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text,
                                              phone: phoneNumberController.text,
                                              userFirstName:
                                                  userFirstNameController.text,
                                              userLastName:
                                                  userLastNameController.text,
                                              userCity: userCityController.text,
                                              userArea: userAreaController.text,
                                              userAddressDetails:
                                                  userAddressController.text,
                                              token: SharedText.deviceToken);
                                        }
                                      },
                                    ),

                                    ///spacer
                                    getSpaceHeight(
                                        AppConstants.pagePaddingDouble),

                                    SocialMediaWidget(
                                      title: AppLocalizations.of(context)!
                                          .lblSignUpWithSocialMedia,
                                      onFacebookClicked: () {
                                        ///Todo:add facebook integration
                                      },
                                      onGoogleClicked: () {
                                        ///Todo:add google integration
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.loginHomePageRoute);
                        },
                        child: SizedBox(
                          height: getWidgetHeight(50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(context)!
                                    .lblHaveAccount,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: 14,
                                textWeight: FontWeight.w600,
                              ),
                              CommonTitleText(
                                textKey: AppLocalizations.of(context)!.lblLogin,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: 14,
                                textWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                      getSpaceHeight(30),
                    ],
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
