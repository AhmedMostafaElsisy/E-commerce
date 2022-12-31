import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';

import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../logic/Password_Cubit/password_cubit.dart';
import '../logic/Password_Cubit/password_states.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController oldPasswordController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        withBack: true,
        appBarBackGroundColor: AppConstants.transparent,
        showBottomIcon: false,
        centerTitle: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblChangePassWord,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w400,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (passwordCtx, passwordStates) {
          if (passwordStates is ChangePasswordStateSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                passwordCtx, RouteNames.loginHomePageRoute, (route) => false);
          }
          if (passwordStates is ChangePasswordStateError) {
            showSnackBar(
              context: passwordCtx,
              title: passwordStates.error!.errorMassage!,
            );
          }
        },
        builder: (passwordCtx, passwordStates) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(passwordCtx).requestFocus(FocusNode());
            },
            child: Container(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/backGround.png",
                    ),
                    fit: BoxFit.fill),
                gradient: LinearGradient(
                  colors: [
                    AppConstants.lightWhiteColor.withOpacity(0.28),
                    AppConstants.lightWhiteColor
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pagePadding),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.pagePaddingDouble),
                            child: commonAssetImageWidget(
                                imageString: "forget_password.png",
                                height: 137,
                                width: 180,
                                fit: BoxFit.contain),
                          ),

                          ///Spacer
                          getSpaceHeight(AppConstants.pagePaddingDouble),

                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                /// old Password
                                CommonTextFormField(
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText: true,
                                  hintKey: AppLocalizations.of(passwordCtx)!
                                      .lblOldPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordIsEmpty;
                                    } else if (value.length < 8) {
                                      return AppLocalizations.of(context)!
                                          .lblPasswordMustBeMoreThan;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      oldPasswordController.text = value!;
                                    });
                                    return null;
                                  },
                                ),

                                getSpaceHeight(AppConstants.pagePadding),

                                /// new Password
                                CommonTextFormField(
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText: true,
                                  hintKey: AppLocalizations.of(passwordCtx)!
                                      .lblNewPassword,
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
                                    setState(() {
                                      passwordController.text = value!;
                                    });
                                    return null;
                                  },
                                ),

                                getSpaceHeight(AppConstants.pagePadding),

                                /// Confirm Password
                                CommonTextFormField(
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 1,
                                  isObscureText: true,
                                  hintKey: AppLocalizations.of(passwordCtx)!
                                      .lblConfirmPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(passwordCtx)!
                                          .lblPasswordIsEmpty;
                                    } else if (value.length < 8) {
                                      return AppLocalizations.of(passwordCtx)!
                                          .lblPasswordMustBeMoreThan;
                                    } else if (value !=
                                        passwordController.text) {
                                      return AppLocalizations.of(passwordCtx)!
                                          .lblPasswordDontMatch;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      confirmPasswordController.text = value!;
                                    });
                                    return null;
                                  },
                                ),

                                /// Retype Password
                                getSpaceHeight(32),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonGlobalButton(
                                      height: 48,
                                      buttonBackgroundColor:
                                          AppConstants.mainColor,
                                      isEnable: passwordController
                                              .text.isNotEmpty &&
                                          confirmPasswordController
                                              .text.isNotEmpty &&
                                          oldPasswordController.text.isNotEmpty,
                                      isLoading: passwordStates
                                          is ChangePasswordStateLoading,
                                      buttonTextSize: 18,
                                      buttonTextFontWeight: FontWeight.w600,
                                      buttonText:
                                      AppLocalizations.of(passwordCtx)!
                                          .lblSave,
                                      onPressedFunction: () {
                                        if (formKey.currentState!.validate()) {
                                          FocusScope.of(passwordCtx)
                                              .requestFocus(FocusNode());
                                          passwordCtx
                                              .read<PasswordCubit>()
                                              .changePassword(
                                                  oldPassword:
                                                      oldPasswordController
                                                          .text,
                                                  password:
                                                      passwordController.text,
                                                  confirmPassword:
                                                      confirmPasswordController
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
                                  buttonTextColor: AppConstants.lightRedColor,
                                  buttonText:
                                  AppLocalizations.of(context)!.lblCancel,
                                  onPressedFunction: () {
                                    Navigator.of(context).pop();
                                  },
                                  height: 48,
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
            ),
          );
        },
      ),
    );
  }
}
