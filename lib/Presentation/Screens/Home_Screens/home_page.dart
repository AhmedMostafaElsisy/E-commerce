import 'package:default_repo_app/Constants/app_constants.dart';
import 'package:default_repo_app/Helpers/shared.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:default_repo_app/Logic/Bloc_Cubits/Language_Cubit/language_cubit.dart';
import 'package:default_repo_app/Presentation/Screens/App_Main_Page/app_main_page.dart';
import 'package:default_repo_app/Presentation/Widgets/common_app_bar_widget.dart';
import 'package:default_repo_app/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Logic/Bloc_Cubits/Setting_Cubit/setting_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<SettingCubit>(context).getFqaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: const CommonAppBar(
        withNotification: true,
        showBottomIcon:false,
        withBack: true,
        titleWidget: CommonTitleText(
          textKey: "Home",
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w500,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Connectivity
            Text(context
                .watch<ConnectivityCubit>()
                .getConnectionStatus
                .toString()),
            Container(
              height: 5.0,
              width: SharedText.screenWidth,
              color: context.watch<ConnectivityCubit>().getConnectionStatus ==
                      'ConnectivityResult.none'
                  ? Colors.red
                  : Colors.green,
            ),

            /// Validations
            // CommonTextFormFieldClass.textFormField(
            //   context,
            //   controller: phoneController,
            //   keyboardType: TextInputType.number,
            //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //   hintText: 'enter phone number',
            //   prefixIcon: FontAwesome.mail,
            //   bgColor: AppConstants.lightGreyBackGround,
            //   prefixIconColor: AppConstants.lightRedColor,
            //   validator: (value) {
            //     if (validatePhone(value!) ==
            //         PhoneValidationResults.emptyPhone) {
            //       return 'empty phone number';
            //     } else if (validatePhone(value) ==
            //         PhoneValidationResults.tooShort) {
            //       return 'enter a valid phone number';
            //     } else if (validatePhone(value) ==
            //         PhoneValidationResults.notMatched) {
            //       return 'invalid phone number';
            //     }
            //
            //     return null;
            //   },
            // ),
            // getSpaceHeight(20),
            // CommonTextFormFieldClass.textFormField(
            //   context,
            //   controller: emailController,
            //   keyboardType: TextInputType.emailAddress,
            //   hintText: 'enter an email address',
            //   prefixIcon: FontAwesome.mail,
            //   bgColor: AppConstants.lightGreyBackGround,
            //   prefixIconColor: AppConstants.lightRedColor,
            //   validator: (value) {
            //     if (validateEmail(value!) ==
            //         EmailValidationResults.emptyEmail) {
            //       return 'empty email address';
            //     } else if (validateEmail(value) ==
            //         EmailValidationResults.notValid) {
            //       return 'enter a valid email address';
            //     } else if (validateEmail(value) ==
            //         EmailValidationResults.emailStartWith) {
            //       return 'email must not start with special chars';
            //     }
            //
            //     return null;
            //   },
            // ),
            // getSpaceHeight(20),
            // CommonTextFormFieldClass.textFormField(
            //   context,
            //   controller: passwordController,
            //   keyboardType: TextInputType.visiblePassword,
            //   hintText: 'enter a password',
            //   prefixIcon: FontAwesome.mail,
            //   bgColor: AppConstants.lightGreyBackGround,
            //   prefixIconColor: AppConstants.lightRedColor,
            //   validator: (value) {
            //     if (validatePassword(value!) ==
            //         PasswordValidationResults.emptyPassword) {
            //       return 'empty password';
            //     } else if (validatePassword(value) ==
            //         PasswordValidationResults.tooShort) {
            //       return 'enter a valid password';
            //     }
            //
            //     return null;
            //   },
            // ),
            getSpaceHeight(20),
            MaterialButton(
              onPressed: () {
                BlocProvider.of<SettingCubit>(context).getTermsAndCondition();
              },
              child: Text(AppLocalizations.of(context)!.lblValidate),
            ),
            getSpaceHeight(20.0),
            IconButton(
                onPressed: () async {
                  var langCubit = LangCubit.get(context);
                  String lang = langCubit.currentLang;
                  debugPrint('lang: $lang');
                  if (lang == "ar") {
                    await langCubit.changeLang('en', context);
                  } else if (lang == "en") {
                    await langCubit.changeLang('ar', context);
                  }

                  setState(() {});
                },
                icon: const Icon(Icons.language))
          ],
        ),
      ),
    );
  }
}
