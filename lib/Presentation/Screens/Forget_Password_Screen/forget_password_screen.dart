import '../../../core/Constants/app_constants.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Forget_Password_Cubit/forget_password_cubit.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Forget_Password_Cubit/forget_password_states.dart';
import 'package:default_repo_app/Presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/common_global_button.dart';
import 'package:default_repo_app/Presentation/Widgets/common_text_form_field_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../core/Helpers/Validators/validators.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../Routes/route_argument_model.dart';
import '../../Routes/route_names.dart';

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
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is SendVerificationToEmailStateSuccess) {
            Navigator.pushNamed(context, RouteNames.verificationCodePageRoute,
                arguments: RouteArgument(
                    emailAddress: emailController.text,));
          }

        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SizedBox(
              width: SharedText.screenWidth,
              height: SharedText.screenHeight,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    AppLocalizations.of(context)!.lblSendYou,
                                textColor: AppConstants.lightBlackColor,
                                textFontSize: 16,
                                textWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CommonTitleText(
                                textKey: AppLocalizations.of(context)!
                                    .lblVerificationCode,
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
                                /// Email
                                CommonTextFormField(
                                  controller: emailController,
                                  radius: AppConstants.smallBorderRadius,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblEnterEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  labelHintStyle: AppConstants.mainTextColor,
                                  borderColor: AppConstants.borderInputColor,
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
                                if (state is SendVerificationToEmailStateError) ...[
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
                                getSpaceHeight(16),

                                CommonGlobalButton(
                                    height: 48,
                                    buttonBackgroundColor:
                                        AppConstants.mainColor,
                                    radius: AppConstants.smallBorderRadius,
                                    buttonTextSize: 18,
                                    isEnable: emailController.text.isNotEmpty,
                                    isLoading: state
                                        is SendVerificationToEmailStateLoading,
                                    buttonTextFontWeight: FontWeight.w400,
                                    buttonText: AppLocalizations.of(context)!
                                        .lblSubmit,
                                    onPressedFunction: () {
                                      if (formKey.currentState!.validate()) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _forgetPasswordCubit
                                            .sendVerificationCodeToEmail(
                                                email: emailController.text);
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
