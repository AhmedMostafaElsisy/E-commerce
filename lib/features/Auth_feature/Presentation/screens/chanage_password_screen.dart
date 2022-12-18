import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';

import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
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

  bool hideOldPassword = true;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

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
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        withBack: true,
        showBottomIcon: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblPassword,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
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
            child: SizedBox(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.pagePadding),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              getSpaceHeight(20),

                              /// Logo
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CommonAssetSvgImageWidget(
                                    imageString: "password_lock_iconb.svg",
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),

                              getSpaceHeight(24),

                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    /// old Password
                                    CommonTextFormField(
                                      withSuffixIcon: true,
                                      labelText:
                                          AppLocalizations.of(passwordCtx)!
                                              .lblOldPassword,
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hideOldPassword = !hideOldPassword;
                                          });
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
                                                    imageString: hideOldPassword
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
                                      isObscureText: hideOldPassword,
                                      radius: AppConstants.smallBorderRadius,
                                      hintKey: AppLocalizations.of(passwordCtx)!
                                          .lblEnterPassword,
                                      labelHintStyle:
                                          AppConstants.mainTextColor,
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 12),
                                        child: CommonAssetSvgImageWidget(
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
                                      withSuffixIcon: true,
                                      labelText:
                                          AppLocalizations.of(passwordCtx)!
                                              .lblNewPassword,
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hidePassword = !hidePassword;
                                          });
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
                                                    imageString: hidePassword
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
                                      isObscureText: hidePassword,
                                      radius: AppConstants.smallBorderRadius,
                                      hintKey: AppLocalizations.of(passwordCtx)!
                                          .lblEnterPassword,
                                      labelHintStyle:
                                          AppConstants.mainTextColor,
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 12),
                                        child: CommonAssetSvgImageWidget(
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
                                        setState(() {
                                          passwordController.text = value!;
                                        });
                                        return null;
                                      },
                                    ),

                                    getSpaceHeight(AppConstants.pagePadding),

                                    /// Confirm Password
                                    CommonTextFormField(
                                      withSuffixIcon: true,
                                      labelText:
                                          AppLocalizations.of(passwordCtx)!
                                              .lblConfirmPassword,
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hideConfirmPassword =
                                                !hideConfirmPassword;
                                          });
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
                                                    imageString:
                                                        hideConfirmPassword
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
                                      isObscureText: hideConfirmPassword,
                                      radius: AppConstants.smallBorderRadius,
                                      hintKey: AppLocalizations.of(passwordCtx)!
                                          .lblEnterPassword,
                                      labelHintStyle:
                                          AppConstants.mainTextColor,
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 12),
                                        child: CommonAssetSvgImageWidget(
                                            imageString: "lock_icon.svg",
                                            fit: BoxFit.contain,
                                            height: 22,
                                            width: 22),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(
                                                  passwordCtx)!
                                              .lblPasswordIsEmpty;
                                        } else if (value.length < 8) {
                                          return AppLocalizations.of(
                                                  passwordCtx)!
                                              .lblPasswordMustBeMoreThan;
                                        } else if (value !=
                                            passwordController.text) {
                                          return AppLocalizations.of(
                                                  passwordCtx)!
                                              .lblPasswordDontMatch;
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          confirmPasswordController.text =
                                              value!;
                                        });
                                        return null;
                                      },
                                    ),

                                    /// Retype Password
                                    getSpaceHeight(16),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonGlobalButton(
                            height: 48,
                            buttonBackgroundColor: AppConstants.mainColor,
                            isEnable: passwordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty &&
                                oldPasswordController.text.isNotEmpty,
                            isLoading:
                                passwordStates is ChangePasswordStateLoading,
                            radius: AppConstants.smallBorderRadius,
                            buttonTextSize: 18,
                            buttonTextFontWeight: FontWeight.w400,
                            buttonText:
                                AppLocalizations.of(passwordCtx)!.lblSubmit,
                            onPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(passwordCtx)
                                    .requestFocus(FocusNode());
                                passwordCtx
                                    .read<PasswordCubit>()
                                    .changePassword(
                                        oldPassword: oldPasswordController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text);
                              }
                            },
                          ),
                        ],
                      ),
                      getSpaceHeight(50),
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
