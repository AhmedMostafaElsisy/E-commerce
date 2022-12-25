import 'dart:async';
import 'dart:developer';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../logic/OTP_Cubit/otp_cubit.dart';
import '../logic/OTP_Cubit/otp_states.dart';

class VerificationCodeScreen extends StatefulWidget {
  final RouteArgument routeArgument;

  const VerificationCodeScreen({Key? key, required this.routeArgument})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late TextEditingController otpController;
  late Timer _timer;
  int _start = 15;
  String otpError = "";
  late OtpCubit _otpCubit;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    _otpCubit = BlocProvider.of<OtpCubit>(context);
    _otpCubit.resetState();

    startTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<OtpCubit, OtpStates>(
        listener: (otpCtx, otpState) {
          if (otpState is OtpSuccessState) {
            if (widget.routeArgument.sourcePage == "forget") {
              Navigator.pushReplacementNamed(
                otpCtx,
                RouteNames.newPasswordPageRoute,
                arguments: RouteArgument(
                    emailAddress: widget.routeArgument.emailAddress,
                    otp: widget.routeArgument.otp),
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                otpCtx,
                RouteNames.loginHomePageRoute,
                (route) => false,
              );
            }
          } else if (otpState is ResendOtpSuccessState) {
            widget.routeArgument.otp = otpState.otp;
          }
        },
        builder: (otpCtx, otpState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(otpCtx).requestFocus(FocusNode());
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.pagePadding) +
                          EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ///spacer
                          getSpaceHeight(60),
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
                          /// Title
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(otpCtx)!
                                    .lblEnterVerificationCode,
                                textColor: AppConstants.mainTextColor,
                                textFontSize: AppConstants.normalFontSize,
                                textWeight: FontWeight.w700,
                              ),
                              getSpaceHeight(AppConstants.smallPadding),
                              CommonTitleText(
                                textKey:
                                    widget.routeArgument.otp!,
                                textColor: AppConstants.mainTextColor,
                                textFontSize: AppConstants.smallFontSize,
                                textWeight: FontWeight.w600,
                              ),
                            ],
                          ),

                          getSpaceHeight(AppConstants.pagePadding),

                          Column(
                            children: [
                              /// OTP
                              Directionality(
                                textDirection: SharedText.currentLocale == "ar"
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: PinCodeTextField(
                                  autoDisposeControllers: false,
                                  textStyle: const TextStyle(
                                      color: AppConstants.greyColor,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w400),
                                  length: 6,
                                  keyboardType: TextInputType.number,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(
                                        AppConstants.smallPadding),
                                    fieldHeight: 48,
                                    fieldWidth: 48,
                                    borderWidth: 1,
                                    activeFillColor:
                                        AppConstants.lightWhiteColor,
                                    inactiveColor:
                                        AppConstants.borderInputColor,
                                    selectedColor: AppConstants.lightShadowColor,
                                    activeColor: AppConstants.borderInputColor,
                                    inactiveFillColor:
                                        AppConstants.lightWhiteColor,
                                    selectedFillColor:
                                        AppConstants.lightWhiteColor,
                                  ),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  backgroundColor: AppConstants.lightWhiteColor,
                                  enableActiveFill: true,
                                  controller: otpController,
                                  enablePinAutofill: true,
                                  onCompleted: (v) {
                                    if (widget.routeArgument.sourcePage ==
                                        "forget") {
                                      log("call the check otp func");
                                      otpCtx.read<OtpCubit>().checkOtp(
                                          emailAddress: widget
                                              .routeArgument.emailAddress!,
                                          otp: otpController.text);
                                    } else {
                                      otpCtx.read<OtpCubit>().verifyAccount(
                                          emailAddress: widget
                                              .routeArgument.emailAddress!,
                                          otp: otpController.text);
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  beforeTextPaste: (text) {
                                    return true;
                                  },
                                  appContext: otpCtx,
                                ),
                              ),
                              if (otpState is OtpErrorState) ...[
                                CommonTitleText(
                                  textKey: otpState.error!.errorMassage ??
                                      AppLocalizations.of(context)!
                                          .lblWrongHappen,
                                  textColor: AppConstants.lightRedColor,
                                  textWeight: FontWeight.w700,
                                  textFontSize: AppConstants.smallFontSize,
                                )
                              ],

                              /// Resend code
                              SizedBox(
                                height: getWidgetHeight(60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblDontRecieveCode,
                                      textColor: AppConstants.mainTextColor,
                                      textFontSize: AppConstants.normalFontSize,
                                      textWeight: FontWeight.w700,
                                    ),
                                    getSpaceWidth(4),
                                    _start != 0
                                        ? SizedBox(
                                            height: getWidgetHeight(60),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CommonTitleText(
                                                  textKey:
                                                      "$_start ${AppLocalizations.of(context)!.lblSecond}",
                                                  textColor: AppConstants
                                                      .lightBlueColor,
                                                  textFontSize: AppConstants
                                                      .smallFontSize,
                                                  textWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              if (_start != 0) {
                                                return;
                                              } else {
                                                if (otpState
                                                    is! OtpLoadingState) {
                                                  otpError = "";
                                                  if (_start > 0) {
                                                  } else {
                                                    _start = 59;
                                                    startTimer();
                                                    setState(() {
                                                      otpController.clear();
                                                    });
                                                    otpCtx
                                                        .read<OtpCubit>()
                                                        .resendOTP(
                                                          email: widget
                                                              .routeArgument
                                                              .emailAddress!,
                                                        );
                                                  }
                                                }
                                              }
                                            },
                                            child: CommonTitleText(
                                              textKey:
                                                  AppLocalizations.of(context)!
                                                      .lblResend,
                                              textColor:
                                                  AppConstants.lightBlueColor,
                                              textFontSize:
                                                  AppConstants.normalFontSize,
                                              textWeight: FontWeight.w700,
                                              isUnderLine: true,
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              getSpaceHeight(16),

                              CommonGlobalButton(
                                  height: 48,
                                  buttonBackgroundColor: AppConstants.mainColor,

                                  buttonTextSize: 18,
                                  buttonTextFontWeight: FontWeight.w400,
                                  isEnable: otpController.text.length == 6,
                                  isLoading: otpState is OtpLoadingState ||
                                      otpState is ResendOtpLoadingState,
                                  buttonText:
                                      AppLocalizations.of(otpCtx)!.lblCheck,
                                  onPressedFunction: () {
                                    if (widget.routeArgument.sourcePage ==
                                        "forget") {
                                      log("call the check otp func");
                                      otpCtx.read<OtpCubit>().checkOtp(
                                          emailAddress: widget
                                              .routeArgument.emailAddress!,
                                          otp: otpController.text);
                                    } else {
                                      otpCtx.read<OtpCubit>().verifyAccount(
                                          emailAddress: widget
                                              .routeArgument.emailAddress!,
                                          otp: otpController.text);
                                    }
                                  },
                                  withIcon: false)
                            ],
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
