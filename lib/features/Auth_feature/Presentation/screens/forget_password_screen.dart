import '../../../../Presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/Constants/app_constants.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_global_button.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_text_form_field_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../Presentation/Routes/route_argument_model.dart';
import '../../../../Presentation/Routes/route_names.dart';
import '../logic/Forget_Password_Cubit/forget_password_cubit.dart';
import '../logic/Forget_Password_Cubit/forget_password_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordCubit _forgetPasswordCubit;
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit = BlocProvider.of<ForgetPasswordCubit>(context);
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
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        elevation: 0,
        withBack: true,
        showBottomIcon: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblForgetPassword,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (forgetCtx, forgetState) {
          if (forgetState is SendVerificationToEmailStateSuccess) {
            Navigator.pushNamed(forgetCtx, RouteNames.verificationCodePageRoute,
                arguments: RouteArgument(
                    emailAddress: emailController.text, otp: forgetState.code));
          }
        },
        builder: (context, state) {
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
                    children: [
                      getSpaceHeight(AppConstants.pagePadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.pagePaddingDouble),
                        child: commonAssetSvgImageWidget(
                            imageString: "forget_password.svg",
                            height: 350,
                            width: 300,
                            fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.pagePadding),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              /// Email
                              CommonTextFormField(
                                labelText:
                                    AppLocalizations.of(context)!.lblEmail,
                                controller: emailController,
                                radius: AppConstants.smallBorderRadius,
                                hintKey:
                                    AppLocalizations.of(context)!.lblEnterEmail,
                                keyboardType: TextInputType.emailAddress,
                                labelHintStyle: AppConstants.mainTextColor,
                                withSuffixIcon: true,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  child: commonAssetSvgImageWidget(
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
                              if (state
                                  is SendVerificationToEmailStateError) ...[
                                getSpaceHeight(8),
                                CommonTitleText(
                                  textKey: state.error!.errorMassage ??
                                      AppLocalizations.of(context)!
                                          .lblWrongHappen,
                                  textColor: AppConstants.mainColor,
                                  textWeight: FontWeight.w700,
                                  textFontSize: AppConstants.smallFontSize,
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonGlobalButton(
                            height: 48,
                            buttonBackgroundColor: AppConstants.mainColor,
                            radius: AppConstants.smallBorderRadius,
                            buttonTextSize: 18,
                            isEnable: emailController.text.isNotEmpty,
                            isLoading:
                                state is SendVerificationToEmailStateLoading,
                            buttonTextFontWeight: FontWeight.w400,
                            buttonText: AppLocalizations.of(context)!.lblSubmit,
                            onPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _forgetPasswordCubit
                                    .sendVerificationCodeToEmail(
                                        email: emailController.text);
                              }
                            },
                            withIcon: false),
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
