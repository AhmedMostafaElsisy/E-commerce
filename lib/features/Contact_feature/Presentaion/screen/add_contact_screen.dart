import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/Validators/validators.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../logic/help_cubit/help_cubit.dart';
import '../logic/help_cubit/help_states.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController subjectController;
  late TextEditingController messageController;
  late TextEditingController idController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    subjectController = TextEditingController();
    messageController = TextEditingController();
    idController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: MainAppPage(
          screenContent: Column(
            children: [
              CommonAppBar(
                withBack: true,
                appBarBackGroundColor: AppConstants.transparent,
                showBottomIcon: false,
                centerTitle: false,
                titleWidget: CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblContactUs,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              BlocConsumer<HelpCubit, HelpStates>(
                listener: (helpCtx, helpState) {
                  if (helpState is HelpAddContactSuccessState) {
                    showSnackBar(
                        context: context,
                        title:
                            AppLocalizations.of(context)!.lblRequestSendSuccess,
                        color: AppConstants.successColor);
                    Navigator.of(context).pop();
                  } else if (helpState is HelpAddContactFailState) {
                    showSnackBar(
                        context: context, title: helpState.error.errorMassage!);
                  }
                },
                builder: (helpCtx, helpState) {
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pagePadding),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTitleText(
                                  textKey: AppLocalizations.of(context)!
                                      .lblSendRequestTitle,
                                  textColor: AppConstants.mainColor,
                                  textFontSize: AppConstants.xLargeFontSize,
                                  textWeight: FontWeight.w500,
                                ),

                                getSpaceHeight(AppConstants.pagePadding),

                                ///name text field
                                CommonTextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblName,
                                  action: TextInputAction.next,
                                  labelHintColor: AppConstants.mainColor,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblNameIsEmpty;
                                    } else if (nameValidator(value)) {
                                      return AppLocalizations.of(context)!
                                          .lblNameBadFormat;
                                    } else if (value.length < 2) {
                                      return AppLocalizations.of(context)!
                                          .lblNameLength;
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

                                ///phone text field
                                CommonTextFormField(
                                  controller: phoneController,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblPhone,
                                  labelHintColor: AppConstants.mainColor,
                                  action: TextInputAction.next,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblPhoneIsEmpty;
                                    } else if (value.length !=
                                        AppConstants.phoneLength) {
                                      return AppLocalizations.of(context)!
                                          .lblPhoneValidate;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (str) {
                                    return str;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.smallPadding),

                                ///email text field
                                CommonTextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  action: TextInputAction.next,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblEmail,
                                  labelHintColor: AppConstants.mainColor,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblEmailIsEmpty;
                                    } else if (!validateEmail(value)) {
                                      return AppLocalizations.of(context)!
                                          .lblEmailBadFormat;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (str) {
                                    return str;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.smallPadding),

                                ///subject text field
                                CommonTextFormField(
                                  controller: subjectController,
                                  action: TextInputAction.next,
                                  hintKey:
                                      AppLocalizations.of(context)!.lblSubject,
                                  labelHintColor: AppConstants.mainColor,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblSubjectIsEmpty;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (str) {
                                    return str;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.smallPadding),

                                ///description text field
                                CommonTextFormField(
                                  controller: messageController,
                                  action: TextInputAction.newline,
                                  hintKey: AppLocalizations.of(context)!
                                      .lblDescription,
                                  labelHintColor: AppConstants.mainColor,
                                  minLines: 5,
                                  maxLines: 6,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .lblDescriptionIsEmpty;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (str) {
                                    return str;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(35),

                                ///next Action
                                CommonGlobalButton(
                                  buttonText:
                                      AppLocalizations.of(context)!.lblSend,
                                  buttonTextSize: AppConstants.xLargeFontSize,
                                  height: 48,
                                  isLoading:
                                      helpState is HelpAddContactLoadingState,
                                  onPressedFunction: () {
                                    if (formKey.currentState!.validate()) {
                                      helpCtx.read<HelpCubit>().addContact(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            subject: subjectController.text,
                                            message: messageController.text,
                                          );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
