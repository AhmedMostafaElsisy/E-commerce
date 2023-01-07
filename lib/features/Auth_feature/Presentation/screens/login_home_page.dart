import 'package:captien_omda_customer/features/Auth_feature/Presentation/screens/widget/scoial_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../logic/Login_Cubit/login_cubit.dart';
import '../logic/Login_Cubit/login_states.dart';
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
            child: MainAppPage(
              screenContent: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidgetWidth(AppConstants.pagePadding)),
                  child: Stack(
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
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      /// Email
                                      CommonTextFormField(
                                        controller: emailController,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblEnterEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        labelHintColor: AppConstants.mainColor,
                                        withSuffixIcon: false,
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
                                          setState(() {});
                                          return null;
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Password
                                      CommonTextFormField(
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: CommonAssetSvgImageWidget(
                                                      imageString:
                                                          hidePassword
                                                              ? "eye_open.svg"
                                                              : "eye_close.svg",
                                                      height: 30,
                                                      width: 30,
                                                      imageColor: AppConstants
                                                          .mainColor,
                                                      fit: BoxFit.contain)),
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        minLines: 1,
                                        maxLines: 1,
                                        isObscureText: hidePassword,
                                        hintKey: AppLocalizations.of(context)!
                                            .lblPassword,
                                        labelHintColor: AppConstants.mainColor,
                                        withSuffixIcon: false,
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
                                      getSpaceHeight(AppConstants.smallPadding),

                                      /// Forget Password Button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                      .lblIsForgetPassword,
                                              textColor: AppConstants.mainColor,
                                              textFontSize: 10,
                                              textWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),

                                      ///spacer
                                      getSpaceHeight(AppConstants.smallPadding),

                                      ///login button
                                      BlocConsumer<OtpCubit, OtpStates>(
                                        listener: (otpCtx, otpState) {
                                          if (otpState
                                              is ResendOtpSuccessState) {
                                            Navigator.pushReplacementNamed(
                                                context,
                                                RouteNames
                                                    .verificationCodePageRoute,
                                                arguments: RouteArgument(
                                                    emailAddress:
                                                        emailController.text,
                                                    otp: otpState.otp));
                                          } else if (otpState
                                              is OtpErrorState) {
                                            // showSnackBar(
                                            //   context: otpCtx,
                                            //   title:
                                            //       otpState.error!.errorMassage!,
                                            // );
                                          }
                                        },
                                        builder: (otpCtx, otpState) {
                                          return CommonGlobalButton(
                                            height: 48,
                                            buttonBackgroundColor:
                                                AppConstants.mainColor,
                                            isEnable: emailController
                                                    .text.isNotEmpty &&
                                                passwordController
                                                    .text.isNotEmpty,
                                            isLoading: loginState
                                                    is UserLoginLoadingState ||
                                                otpState
                                                    is ResendOtpLoadingState,
                                            buttonTextSize:
                                                AppConstants.normalFontSize,
                                            buttonTextFontWeight:
                                                FontWeight.w700,
                                            buttonText:
                                                AppLocalizations.of(context)!
                                                    .lblLogin,
                                            onPressedFunction: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                loginCtx
                                                    .read<LoginCubit>()
                                                    .login(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        token: SharedText
                                                            .deviceToken);
                                              }
                                            },
                                          );
                                        },
                                      ),

                                      ///spacer
                                      getSpaceHeight(
                                          AppConstants.pagePaddingDouble),

                                      SocialMediaWidget(
                                        title: AppLocalizations.of(context)!
                                            .lblLoginWithSocialMedia,
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
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, RouteNames.singUpPageRoute);
                            },
                            child: SizedBox(
                              height: getWidgetHeight(50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonTitleText(
                                    textKey: AppLocalizations.of(context)!
                                        .lblDoNotHaveAccount,
                                    textColor: AppConstants.lightBlackColor,
                                    textFontSize: 14,
                                    textWeight: FontWeight.w600,
                                  ),
                                  CommonTitleText(
                                    textKey: AppLocalizations.of(context)!
                                        .lblCreateAccount,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
