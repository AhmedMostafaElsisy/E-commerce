
import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';

import '../../../../core/Constants/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../logic/Login_Cubit/login_states.dart';
import '../logic/Login_Cubit/login_cubit.dart';
import '../logic/OTP_Cubit/otp_cubit.dart';
import '../logic/OTP_Cubit/otp_states.dart';

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
      backgroundColor: AppConstants.backGroundColor,
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (loginCtx, loginState) {
          if (loginState is UserLogInSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.mainBottomNavPageRoute,
              (route) => false,
            );
            BlocProvider.of<BottomNavCubit>(context).selectItem(0);
          }
          if (loginState is UserLoginErrorState) {
            if (loginState.error!.type ==
                CustomStatusCodeErrorType.unVerified) {
              BlocProvider.of<OtpCubit>(context)
                  .resendOTP(email: emailController.text);
            }
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
            child: SizedBox(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///spacer
                    getSpaceHeight(50),

                    ///app logo
                    commonAssetImageWidget(
                      imageString: "splash_logo.png",
                      height: 210,
                      width: 180,
                    ),

                    ///spacer
                    getSpaceHeight(50),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppConstants.lightWhiteColor,
                            borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(AppConstants.borderRadius),
                              topLeft:
                                  Radius.circular(AppConstants.borderRadius),
                            )),
                        padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.pagePadding) +
                            EdgeInsets.only(
                              bottom: MediaQuery.of(loginCtx).viewInsets.bottom,
                            ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ///spacer
                            getSpaceHeight(24),

                            /// Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonTitleText(
                                  textKey:
                                      AppLocalizations.of(context)!.lblLogin,
                                  textColor: AppConstants.lightBlackColor,
                                  textFontSize: AppConstants.normalFontSize,
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
                                    labelText:
                                        AppLocalizations.of(context)!.lblEmail,
                                    controller: emailController,
                                    radius: AppConstants.smallBorderRadius,
                                    hintKey: AppLocalizations.of(context)!
                                        .lblEnterEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    labelHintStyle: AppConstants.mainTextColor,
                                    withSuffixIcon: true,
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                      child: CommonAssetSvgImageWidget(
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
                                    labelText: AppLocalizations.of(context)!
                                        .lblPassword,
                                    hintKey: AppLocalizations.of(context)!
                                        .lblEnterPassword,
                                    labelHintStyle: AppConstants.mainTextColor,
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
                                      setState(() {});
                                      return null;
                                    },
                                  ),

                                  ///spacer
                                  getSpaceHeight(AppConstants.pagePadding),

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
                                          textKey: AppLocalizations.of(context)!
                                              .lblIsForgetPassword,
                                          textColor:
                                              AppConstants.lightBlueColor,
                                          textFontSize: 12,
                                          textWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///spacer
                                  getSpaceHeight(
                                      AppConstants.pagePaddingDouble),

                                  ///login button
                                  BlocConsumer<OtpCubit, OtpStates>(
                                    listener: (otpCtx, otpState) {
                                      if(otpState is ResendOtpSuccessState){
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.verificationCodePageRoute,
                                            arguments: RouteArgument(
                                                emailAddress: emailController.text,
                                                otp: otpState.otp));
                                      }else if (otpState is OtpErrorState){
                                        showSnackBar(
                                          context: otpCtx,
                                          title: otpState.error!.errorMassage!,
                                        );
                                      }
                                    },
                                    builder: (otpCtx, otpState) {
                                      return CommonGlobalButton(
                                        height: 48,
                                        buttonBackgroundColor:
                                            AppConstants.mainColor,
                                        isEnable: emailController
                                                .text.isNotEmpty &&
                                            passwordController.text.isNotEmpty,
                                        isLoading: loginState
                                                is UserLoginLoadingState ||
                                            otpState is ResendOtpLoadingState,
                                        buttonTextSize:
                                            AppConstants.normalFontSize,
                                        buttonTextFontWeight: FontWeight.w700,
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
                                      );
                                    },
                                  ),

                                  ///spacer
                                  getSpaceHeight(AppConstants.pagePadding),

                                  ///create account
                                  CommonGlobalButton(
                                    height: 48,
                                    buttonBackgroundColor:
                                        AppConstants.lightWhiteColor,
                                    buttonTextColor: AppConstants.mainColor,
                                    borderColor: AppConstants.mainColor,
                                    showBorder: true,
                                    buttonTextSize: AppConstants.normalFontSize,
                                    buttonTextFontWeight: FontWeight.w700,
                                    buttonText: AppLocalizations.of(context)!
                                        .lblCreateAccount,
                                    onPressedFunction: () {
                                      Navigator.pushNamed(
                                          context, RouteNames.singUpPageRoute);
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
              ),
            ),
          );
        },
      ),
    );
  }
}
