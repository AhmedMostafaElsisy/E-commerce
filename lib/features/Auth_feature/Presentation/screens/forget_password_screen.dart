import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../logic/Password_Cubit/password_cubit.dart';
import '../logic/Password_Cubit/password_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late PasswordCubit _forgetPasswordCubit;
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit = BlocProvider.of<PasswordCubit>(context);
    _forgetPasswordCubit.resetState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (forgetCtx, forgetState) {
          if (forgetState is SendVerificationToEmailStateSuccess) {
            Navigator.pushReplacementNamed(
                forgetCtx, RouteNames.verificationCodePageRoute,
                arguments: RouteArgument(
                    sourcePage: "forget",
                    emailAddress: emailController.text,
                    otp: forgetState.code));
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///spacer
                        getSpaceHeight(110),
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
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!
                              .lblForgetPasswordTitle,
                          textFontSize: AppConstants.smallFontSize,
                          textColor: AppConstants.mainTextColor,
                          textWeight: FontWeight.w700,
                          lines: 3,
                        ),

                        ///Spacer
                        getSpaceHeight(AppConstants.pagePaddingDouble),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.pagePadding),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                /// Email
                                CommonTextFormField(
                                  controller: emailController,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterEmail,
                                  keyboardType: TextInputType.emailAddress,
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
                                if (state
                                    is SendVerificationToEmailStateError) ...[
                                  getSpaceHeight(AppConstants.smallPadding),
                                  CommonTitleText(
                                    textKey: state.error!.errorMassage ??
                                        AppLocalizations.of(context)!
                                            .lblWrongHappen,
                                    textColor: AppConstants.lightRedColor,
                                    textWeight: FontWeight.w700,
                                    textFontSize: AppConstants.smallFontSize,
                                  )
                                ],

                                ///Spacer
                                getSpaceHeight(
                                    AppConstants.pagePaddingDouble * 3),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonGlobalButton(
                                              height: 48,
                                              buttonBackgroundColor:
                                                  AppConstants.mainColor,
                                              buttonTextSize: 18,
                                              isEnable: emailController
                                                  .text.isNotEmpty,
                                              isLoading: state
                                                  is SendVerificationToEmailStateLoading,
                                              buttonTextFontWeight:
                                                  FontWeight.w400,
                                              buttonText:
                                                  AppLocalizations.of(context)!
                                                      .lblSend,
                                              onPressedFunction: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  _forgetPasswordCubit
                                                      .sendVerificationCodeToEmail(
                                                          email: emailController
                                                              .text);
                                                }
                                              },
                                              withIcon: false),
                                        ],
                                      ),
                                      getSpaceHeight(50),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
