import '../../../../Presentation/Routes/route_names.dart';
import '../../../../Presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../Presentation/Widgets/common_global_button.dart';
import '../../../../Presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../Presentation/Widgets/common_title_text.dart';
import '../../../../Presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/Constants/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../logic/Login_Cubit/login_states.dart';
import '../logic/Login_Cubit/login_cubit.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  final formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (loginCtx, loginState) {
          if (loginState is UserLogInSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.homePageRoute,
              (route) => false,
            );
          }
          if (loginState is UserLoginErrorState) {
            showSnackBar(
              context: loginCtx,
              title: loginState.error!.errorMassage!,
            );
          }
        },
        builder: (loginCtx, loginState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                SizedBox(
                  width: SharedText.screenWidth,
                  height: SharedText.screenHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getSpaceHeight(150),
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
                                    textKey:
                                        AppLocalizations.of(context)!.lblLogin,
                                    textColor: AppConstants.lightBlackColor,
                                    textFontSize: 16,
                                    textWeight: FontWeight.w700,
                                  ),
                                ],
                              ),

                              ///spacer

                              getSpaceHeight(16),

                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    /// Email
                                    CommonTextFormField(
                                      controller: emailController,
                                      radius: AppConstants.smallBorderRadius,
                                      hintKey: AppLocalizations.of(context)!
                                          .lblEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      labelHintStyle:
                                          AppConstants.mainTextColor,
                                      borderColor:
                                          AppConstants.borderInputColor,
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
                                        setState(() {});
                                        return null;
                                      },
                                    ),

                                    ///spacer

                                    getSpaceHeight(16),

                                    /// Password
                                    CommonTextFormField(
                                      withSuffixIcon: true,
                                      controller: passwordController,
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
                                                fit: BoxFit.fill)),
                                      ),
                                      keyboardType: TextInputType.text,
                                      minLines: 1,
                                      maxLines: 1,
                                      isObscureText: hidePassword,
                                      radius: AppConstants.smallBorderRadius,
                                      hintKey: AppLocalizations.of(context)!
                                          .lblPassword,
                                      labelHintStyle:
                                          AppConstants.mainTextColor,
                                      borderColor:
                                          AppConstants.borderInputColor,
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
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {});
                                        return null;
                                      },
                                    ),

                                    getSpaceHeight(4),

                                    /// Forget Password Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                RouteNames
                                                    .forgetPasswordPageRoute);
                                          },
                                          child: CommonTitleText(
                                            textKey:
                                                AppLocalizations.of(context)!
                                                    .lblForgetPassword,
                                            textColor:
                                                AppConstants.lightBlackColor,
                                            textFontSize: 12,
                                            textWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///spacer
                                    getSpaceHeight(16),

                                    ///login button
                                    CommonGlobalButton(
                                        height: 48,
                                        buttonBackgroundColor:
                                            AppConstants.mainColor,
                                        isEnable: emailController
                                                .text.isNotEmpty &&
                                            passwordController.text.isNotEmpty,
                                        isLoading:
                                            loginState is UserLoginLoadingState,
                                        radius: AppConstants.smallBorderRadius,
                                        buttonTextSize: 18,
                                        buttonTextFontWeight: FontWeight.w400,
                                        buttonText:
                                            AppLocalizations.of(context)!
                                                .lblLogin,
                                        onPressedFunction: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            loginCtx.read<LoginCubit>().login(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                token: SharedText.deviceToken);
                                          }
                                        },
                                        withIcon: false),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ///don't have and account button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTitleText(
                          textKey:
                              AppLocalizations.of(context)!.lblDoNotHaveAccount,
                          textColor: AppConstants.lightBlackColor,
                          textFontSize: 13,
                          textWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.singUpPageRoute);
                          },
                          child: CommonTitleText(
                            textKey: AppLocalizations.of(context)!.lblJoinNow,
                            textColor: AppConstants.lightBlackColor,
                            textFontSize: 14,
                            textWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    getSpaceHeight(50),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
