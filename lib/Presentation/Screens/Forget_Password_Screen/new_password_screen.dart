import 'package:default_repo_app/Constants/app_constants.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Forget_Password_Cubit/forget_password_cubit.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Forget_Password_Cubit/forget_password_states.dart';
import 'package:default_repo_app/Presentation/Routes/route_argument_model.dart';
import 'package:default_repo_app/Presentation/Routes/route_names.dart';
import 'package:default_repo_app/Presentation/Widgets/common_asset_image_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/common_global_button.dart';
import 'package:default_repo_app/Presentation/Widgets/common_text_form_field_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/common_title_text.dart';
import 'package:default_repo_app/Presentation/Widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Helpers/Validators/validators.dart';
import '../../../Helpers/shared.dart';

class NewPasswordScreen extends StatefulWidget {
  final RouteArgument argument;

  const NewPasswordScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
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
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/bg2.png",
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo
                  Stack(
                    children: [
                      Stack(children: [
                        commonAssetImageWidget(
                            imageString: "elipse-pattern.png",
                            height: getWidgetHeight(200),
                            width: SharedText.screenWidth,
                            fit: BoxFit.fill),
                        Positioned(
                            top: getWidgetHeight(50),
                            left: getWidgetWidth(16),
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: getWidgetWidth(40),
                                height: getWidgetHeight(40),
                                decoration: BoxDecoration(
                                  color: AppConstants.lightWhiteColor,
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.smallRadius),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: commonAssetSvgImageWidget(
                                        imageString: "back_arrow_icon.svg",
                                        height: 14,
                                        width: 7,
                                        imageColor: AppConstants.mainColor),
                                  ),
                                ),
                              ),
                            )),
                      ]),

                      /// Logo
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonAssetSvgImageWidget(
                                  imageString: "password_lock_icon.svg",
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                          getSpaceHeight(8),
                          CommonTitleText(
                            textKey: AppLocalizations.of(passwordCtx)!
                                .lblNewPassword,
                            textColor: AppConstants.lightWhiteColor,
                            textFontSize: 18,
                            textWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),

                  getSpaceHeight(90),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pagePadding),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          /// Title
                          Row(
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(passwordCtx)!
                                    .lblCreateNewPassword,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: 16,
                                textWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(passwordCtx)!
                                    .lblMoreThan8Characters,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: 16,
                                textWeight: FontWeight.w700,
                              ),
                            ],
                          ),

                          getSpaceHeight(24),

                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                /// Password
                                CommonTextFormField(
                                  withSuffixIcon: true,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: commonAssetSvgImageWidget(
                                          imageString: hidePassword
                                              ? "eye_open.svg"
                                              : "eye_close.svg",
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
                                  hintKey: AppLocalizations.of(passwordCtx)!
                                      .lblEnterPassword,
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
                                    }
                                    else if (complexValidationSpecialCharactersValidator(
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

                                getSpaceHeight(16),

                                /// Confirm Password
                                CommonTextFormField(
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
                                      child: commonAssetSvgImageWidget(
                                          imageString: hideConfirmPassword
                                              ? "eye_open.svg"
                                              : "eye_close.svg",
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
                                  hintKey: AppLocalizations.of(passwordCtx)!
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
                                getSpaceHeight(16),

                                CommonGlobalButton(
                                    height: 48,
                                    buttonBackgroundColor:
                                        AppConstants.mainColor,
                                    isEnable:
                                        passwordController.text.isNotEmpty &&
                                            confirmPasswordController
                                                .text.isNotEmpty,
                                    isLoading: passwordStates
                                        is ChangePasswordStateLoading,
                                    radius: AppConstants.smallBorderRadius,
                                    buttonTextSize: 18,
                                    buttonTextFontWeight: FontWeight.w400,
                                    buttonText:
                                        AppLocalizations.of(passwordCtx)!
                                            .lblVerify,
                                    onPressedFunction: () {
                                      if (formKey.currentState!.validate()) {
                                        FocusScope.of(passwordCtx)
                                            .requestFocus(FocusNode());
                                        passwordCtx
                                            .read<ForgetPasswordCubit>()
                                            .changeNewPassword(
                                                email: widget
                                                    .argument.emailAddress!,
                                                confirmPassword:
                                                    confirmPasswordController
                                                        .text,
                                                password:
                                                    passwordController.text);
                                      }
                                    },
                                    withIcon: false)
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
