import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_app_bar_icon_with_counter.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/screens/app_main_screen.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Widgets/banner_carousel_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/request_cubit/home_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/request_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../../core/setting_feature/Logic/setting_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeContentCubit;
  late SettingCubit settingCubit;
  late TextEditingController searchController;

  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    homeContentCubit = BlocProvider.of<HomeCubit>(context);
    settingCubit = BlocProvider.of<SettingCubit>(context);
    searchController = TextEditingController();
    locationController = TextEditingController();
    settingCubit.getSetting();
    homeContentCubit.getHomeContent();
  }

  @override
  Widget build(BuildContext context) {
    //todo :change it to screen that cc used on app and remove yours
    return AppMainScreen(
      screen: BlocConsumer<HomeCubit, HomeState>(
        listener: (homeCtx, homeState) {},
        builder: (homeCtx, homeState) {
          if (homeState is HomeContentLoadingState) {
            return Column(
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: AppConstants.mainColor,
                  ),
                )
              ],
            );
          } else if (homeState is HomeGetContentFailedState) {
            return CommonError(
              errorMassage: homeState.error.errorMassage,
              withButton: true,
              onTap: () => homeContentCubit.getHomeContent(),
            );
          } else {
            return Scaffold(
                backgroundColor: AppConstants.transparent,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getWidgetHeight(35),
                      horizontal: getWidgetWidth(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonAssetImageWidget(
                          imageString: 'side_logo.png',
                          height: 36,
                          width: 100,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CommonAppBarImageWithCounter(
                              imagePath: "fav_disable.svg",
                              withCounter: false,
                            ),
                            CommonAppBarImageWithCounter(
                              imagePath: "chat.svg",
                              withCounter: true,
                              itemCounter: 19,
                            ),
                            CommonAppBarImageWithCounter(
                              imagePath: "cart.svg",
                              withCounter: true,
                              itemCounter: 19,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Email
                    SizedBox(
                      width: getWidgetWidth(343),
                      height: getWidgetHeight(36),
                      child: CommonTextFormField(
                        controller: searchController,
                        isReadOnly: true,
                        hintKey: AppLocalizations.of(context)!.lblSearchOn,
                        keyboardType: TextInputType.text,
                        labelHintColor: AppConstants.lightBlackColor,
                        labelHintFontSize: AppConstants.xSmallFontSize,
                        radius: AppConstants.textFormBorderRadius,
                        withSuffixIcon: true,
                        suffixIcon: SizedBox(
                          width: getWidgetWidth(16),
                          height: getWidgetHeight(16),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: CommonAssetSvgImageWidget(
                                  imageString: "search.svg",
                                  height: 16,
                                  width: 16,
                                  imageColor: AppConstants.mainColor,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                          return null;
                        },
                      ),
                    ),

                    ///spacer
                    getSpaceHeight(4),

                    /// Password
                    SizedBox(
                      width: getWidgetWidth(343),
                      height: getWidgetHeight(36),
                      child: CommonTextFormField(
                        controller: locationController,
                        radius: AppConstants.textFormBorderRadius,
                        keyboardType: TextInputType.text,
                        isReadOnly: true,
                        minLines: 1,
                        maxLines: 1,
                        hintKey:
                            AppLocalizations.of(context)!.lblDetectLocation,
                        labelHintColor: AppConstants.lightBlackColor,
                        labelHintFontSize: AppConstants.xSmallFontSize,
                        withSuffixIcon: true,
                        suffixIcon: SizedBox(
                          width: getWidgetWidth(16),
                          height: getWidgetHeight(16),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: CommonAssetSvgImageWidget(
                                  imageString: "location.svg",
                                  height: 16,
                                  width: 16,
                                  imageColor: AppConstants.mainColor,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                          return null;
                        },
                      ),
                    ),
                    getSpaceHeight(12),

                    if (homeContentCubit.homeContent.banners.isNotEmpty)
                      SizedBox(
                          height: getWidgetHeight(132),
                          child: BannerCarouselWidget(
                            banners: homeContentCubit.homeContent.banners,
                          )),
                  ],
                ));
          }
        },
      ),
    );
  }
}
