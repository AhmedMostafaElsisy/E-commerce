import 'dart:async';

import 'package:captien_omda_customer/Presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/Presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_global_button.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../Presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../OTP_Cubit/otp_cubit.dart';
import '../OTP_Cubit/otp_states.dart';

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
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        elevation: 0,
        withBack: true,
        showBottomIcon: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblVerificationCodeSt,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: BlocConsumer<OtpCubit, OtpStates>(
        listener: (context, state) {
          if (state is OtpSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.loginHomePageRoute,
              (route) => false,
            );
          }
        },
        builder: (otpCtx, otpState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(otpCtx).requestFocus(FocusNode());
            },
            child: SizedBox(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSpaceHeight(20),
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
                          commonAssetSvgImageWidget(
                              imageString: "sucess_otp.svg",
                              height: (350),
                              width: 300,
                              fit: BoxFit.contain),
                          getSpaceHeight(AppConstants.pagePadding),

                          /// Title
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(otpCtx)!
                                    .lblEnterVerificationCode,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: AppConstants.normalFontSize,
                                textWeight: FontWeight.w700,
                              ),
                              getSpaceHeight(AppConstants.smallPadding),
                              CommonTitleText(
                                textKey: AppLocalizations.of(otpCtx)!
                                    .lblSendToYourEmail,
                                textColor: AppConstants.mainTextColor,
                                textFontSize: AppConstants.smallFontSize,
                                textWeight: FontWeight.w600,
                              ),
                              getSpaceHeight(AppConstants.smallPadding / 2),
                              CommonTitleText(
                                textKey:
                                    "${widget.routeArgument.emailAddress!}-${widget.routeArgument.otp!}",
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
                              PinCodeTextField(
                                textStyle: const TextStyle(
                                    color: AppConstants.mainTextColor,
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
                                      AppConstants.containerBorderRadius),
                                  fieldHeight: 48,
                                  fieldWidth: 48,
                                  borderWidth: 1,
                                  activeFillColor: AppConstants.backGroundColor,
                                  inactiveColor: AppConstants.borderInputColor,
                                  selectedColor: AppConstants.backGroundColor,
                                  activeColor: AppConstants.borderInputColor,
                                  inactiveFillColor:
                                      AppConstants.backGroundColor,
                                  selectedFillColor:
                                      AppConstants.backGroundColor,
                                ),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                backgroundColor: Colors.transparent,
                                enableActiveFill: true,
                                controller: otpController,
                                onCompleted: (v) {},
                                onChanged: (value) {
                                  setState(() {});
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                appContext: otpCtx,
                              ),
                              if (otpState is OtpErrorState) ...[
                                CommonTitleText(
                                  textKey: otpState.error!.errorMassage ??
                                      AppLocalizations.of(context)!
                                          .lblWrongHappen,
                                  textColor: AppConstants.mainColor,
                                  textWeight: FontWeight.w700,
                                  textFontSize: AppConstants.smallFontSize,
                                )
                              ],

                              /// Resend code
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
                                            textColor:
                                                AppConstants.lightBlackColor,
                                            textFontSize:
                                                AppConstants.smallFontSize,
                                            textWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),

                              // getSpaceHeight(16),

                              _start == 0
                                  ? SizedBox(
                                      height: getWidgetHeight(60),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonTitleText(
                                            textKey:
                                                AppLocalizations.of(context)!
                                                    .lblDontRecieveCode,
                                            textColor:
                                                AppConstants.lightBlackColor,
                                            textFontSize:
                                                AppConstants.normalFontSize,
                                            textWeight: FontWeight.w600,
                                          ),
                                          getSpaceWidth(4),
                                          GestureDetector(
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
                                    )
                                  : const SizedBox(),

                              getSpaceHeight(16),

                              CommonGlobalButton(
                                  height: 48,
                                  buttonBackgroundColor: AppConstants.mainColor,
                                  radius: AppConstants.smallBorderRadius,
                                  buttonTextSize: 18,
                                  buttonTextFontWeight: FontWeight.w400,
                                  isEnable: otpController.text.length == 6,
                                  isLoading: otpState is OtpLoadingState ||
                                      otpState is ResendOtpLoadingState,
                                  buttonText:
                                      AppLocalizations.of(otpCtx)!.lblConfirm,
                                  onPressedFunction: () {
                                    otpCtx.read<OtpCubit>().verifyAccount(
                                        emailAddress:
                                            widget.routeArgument.emailAddress!,
                                        otp: otpController.text);
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
