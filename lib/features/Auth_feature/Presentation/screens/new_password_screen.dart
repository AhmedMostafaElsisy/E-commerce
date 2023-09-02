import '../../../../core/Constants/app_constants.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../logic/Password_Cubit/password_cubit.dart';
import '../logic/Password_Cubit/password_states.dart';

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
      resizeToAvoidBottomInset: false,
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
            child: MainAppPage(
              screenContent: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pagePadding),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ///spacer
                                getSpaceHeight(60),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          AppConstants.pagePaddingDouble),
                                  child: commonAssetImageWidget(
                                      imageString: "forget_password.png",
                                      height: 137,
                                      width: 180,
                                      fit: BoxFit.contain),
                                ),

                                ///Spacer
                                getSpaceHeight(AppConstants.pagePaddingDouble),

                                /// Title
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(passwordCtx)!
                                          .lblNewPassword,
                                      textColor: AppConstants.mainTextColor,
                                      textFontSize: AppConstants.normalFontSize,
                                      textWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),

                                getSpaceHeight(AppConstants.pagePaddingDouble),

                                /// Password
                                CommonTextFormField(
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
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
                                  hintKey: AppLocalizations.of(passwordCtx)!
                                      .lblPassword,
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

                                getSpaceHeight(AppConstants.smallPadding),

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
                                getSpaceHeight(38),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                              .changeNewPassword(
                                                  code: widget.argument.otp!,
                                                  email: widget
                                                      .argument.emailAddress!,
                                                  confirmPassword:
                                                      confirmPasswordController
                                                          .text,
                                                  password:
                                                      passwordController.text);
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
