import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../presentation/Widgets/common_app_bar_widget.dart';
import '../../presentation/Widgets/common_title_text.dart';
import '../../presentation/screen/main_app_page.dart';
import 'Logic/setting_cubit.dart';
import 'Logic/setting_cubit_states.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  late SettingCubit settingCubit;

  @override
  void initState() {
    super.initState();
    settingCubit = BlocProvider.of<SettingCubit>(context);
    settingCubit.getTermData();
  }

  @override
  Widget build(BuildContext context) {
    return MainAppPage(
      screenContent: Scaffold(
        backgroundColor: AppConstants.transparent,
        appBar: CommonAppBar(
          withBack: true,
          titleWidget: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblOutTermsAndConditions,
          ),
          centerTitle: false,
          showBottomIcon: false,
          appBarBackGroundColor: AppConstants.transparent,
        ),
        body: BlocConsumer<SettingCubit, SettingCubitState>(
          listener: (sittingCtx, sittingState) {},
          builder: (sittingCtx, sittingState) {
            if (sittingState is SettingFailedState) {
              return CommonError(
                errorMassage: sittingState.error.errorMassage,
                withButton: true,
                onTap: () => sittingCtx.read<SettingCubit>().getSetting(),
              );
            } else if (sittingState is SettingLoadingState) {
              return const CommonLoadingWidget();
            } else {
              if (sittingCtx.read<SettingCubit>().termsModel.terms!.isEmpty) {
                return EmptyScreen(
                  imageWidth: 250,
                  imageHeight: 200,
                  titleKey:
                      AppLocalizations.of(context)!.lblNoTermsAndConditions,
                  withButton: false,
                  imageString: '',
                );
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(
                            getWidgetHeight(AppConstants.pagePadding)) +
                        EdgeInsets.symmetric(
                            vertical:
                                getWidgetHeight(AppConstants.pagePadding)),
                    child: RichText(
                      text: HTML.toTextSpan(
                        context,
                        sittingCtx.read<SettingCubit>().termsModel.terms!,
                        defaultTextStyle:
                            Theme.of(context).textTheme.headline4?.copyWith(
                                  color: AppConstants.mainTextColor,
                                  fontSize: AppConstants.smallFontSize,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.visible,
                                ),
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
