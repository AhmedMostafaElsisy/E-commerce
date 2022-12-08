
import 'dart:async';

import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import 'package:captien_omda_customer/Logic/Bloc_Cubits/OTP_Cubit/otp_cubit.dart';
import 'package:captien_omda_customer/Logic/Bloc_Cubits/OTP_Cubit/otp_states.dart';
import 'package:captien_omda_customer/Presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/Presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_global_button.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


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
      body: BlocConsumer<OtpCubit, OtpStates>(
        listener: (context, state) {
          if (state is OtpSuccessState) {
            Navigator.pushNamedAndRemoveUntil(context,
                RouteNames.newPasswordPageRoute, (route) => route.isFirst,
                arguments: RouteArgument(
                  emailAddress: widget.routeArgument.emailAddress!,
                ));
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonAssetSvgImageWidget(
                                  imageString: "email_verifiy_icon.svg",
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                          getSpaceHeight(8),
                          CommonTitleText(
                            textKey: AppLocalizations.of(otpCtx)!
                                .lblVerificationCodeSt,
                            textColor: AppConstants.lightWhiteColor,
                            textFontSize: 18,
                            textWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),

                  getSpaceHeight(60),
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
                                textKey: AppLocalizations.of(otpCtx)!
                                    .lblEnterVerificationCode,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: 16,
                                textWeight: FontWeight.w700,
                              ),
                            ],
                          ),


                          getSpaceHeight(24),

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
                                      AppConstants.smallBorderRadius),
                                  fieldHeight: 48,
                                  fieldWidth: 48,
                                  borderWidth: 1,
                                  activeFillColor: AppConstants.lightWhiteColor,
                                  inactiveColor: AppConstants.borderInputColor,
                                  selectedColor: AppConstants.mainColor,
                                  activeColor: AppConstants.borderInputColor,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.transparent,
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
                                      height: getWidgetHeight(80),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonTitleText(
                                            textKey: _start.toString() +
                                                " " +
                                                AppLocalizations.of(context)!
                                                    .lblSecond,
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
                                      height: getWidgetHeight(80),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonTitleText(
                                            textKey:
                                                AppLocalizations.of(context)!
                                                    .lblDontRecieveCode,
                                            textColor:
                                                AppConstants.mainTextColor,
                                            textFontSize:
                                                AppConstants.normalFontSize,
                                            textWeight: FontWeight.w500,
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
                                              textColor: AppConstants.mainColor,
                                              textFontSize:
                                                  AppConstants.normalFontSize,
                                              textWeight: FontWeight.w500,
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
