import 'package:captien_omda_customer/core/Helpers/Extensions/prevent_string_spacing.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared_texts.dart';
import '../../../../../core/presentation/Routes/route_names.dart';
import '../../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../../logic/Bottom_Nav_Cubit/bottom_nav_cubit_state.dart';
import '../Home_Screens/home_page.dart';
import '../Request_History/request_history_list.dart';
import 'bottom_nav_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    /// Pages
    const List<Widget> widgetOptions = <Widget>[
      HomePage(),
      RequestHistoryList(),
    ];

    return BlocConsumer<BottomNavCubit, BottomNavCubitState>(
      listener: (bottomNavCtx, bottomNavState) {},
      builder: (bottomNavCtx, bottomNavState) {
        return Scaffold(
          backgroundColor: AppConstants.lightWhiteColor,
          appBar: CommonAppBar(
            withNotification: true,
            showBottomIcon: false,
            withBack: false,
            showLeadingWidget: true,
            leadingWidget: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.profilePageRoute);
              },
              child: commonCachedImageWidget(
                  context, SharedText.currentUser!.image!,
                  isProfile: true,
                  isCircular: true,
                  height: 30,
                  width: 30,
                  radius: 1000,
                  fit: BoxFit.contain),
            ),
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblHello,
                  textColor: AppConstants.mainTextColor,
                  textWeight: FontWeight.w500,
                  textFontSize: AppConstants.smallFontSize,
                ),
                CommonTitleText(
                  textKey:
                      SharedText.currentUser!.name!.getStringWithoutSpacings(),
                  textColor: AppConstants.mainColor,
                  textWeight: FontWeight.w700,
                  textFontSize: AppConstants.smallFontSize,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: AppConstants.lightWhiteColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(
                        AppConstants.containerOfListTitleBorderRadius),
                    topLeft: Radius.circular(
                        AppConstants.containerOfListTitleBorderRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: AppConstants.redShadowColor.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 0))
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getWidgetHeight(AppConstants.pagePadding)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        bottomNavCtx.read<BottomNavCubit>().selectItem(0);
                      },
                      child: BottomBarItem(
                        image: "home.svg",
                        isSelected:
                            bottomNavCtx.read<BottomNavCubit>().selectedIndex ==
                                0,
                        title: AppLocalizations.of(context)!.lblHome,
                      ),
                    ),
                    getSpaceWidth(AppConstants.pagePadding),
                    InkWell(
                      onTap: () {
                        bottomNavCtx.read<BottomNavCubit>().selectItem(1);
                      },
                      child: BottomBarItem(
                        image: "stores.svg",
                        isSelected:
                            bottomNavCtx.read<BottomNavCubit>().selectedIndex ==
                                1,
                        title: AppLocalizations.of(context)!.lblStores,
                      ),
                    ),
                    getSpaceWidth(AppConstants.pagePadding),
                    InkWell(
                      onTap: () {
                        bottomNavCtx.read<BottomNavCubit>().selectItem(2);
                      },
                      child: BottomBarItem(
                        image: "categories.svg",
                        isSelected:
                            bottomNavCtx.read<BottomNavCubit>().selectedIndex ==
                                2,
                        title: AppLocalizations.of(context)!.lblCategories,
                      ),
                    ),
                    getSpaceWidth(AppConstants.pagePadding),
                    InkWell(
                      onTap: () {
                        bottomNavCtx.read<BottomNavCubit>().selectItem(3);
                      },
                      child: BottomBarItem(
                        image: "orders.svg",
                        isSelected:
                            bottomNavCtx.read<BottomNavCubit>().selectedIndex ==
                                3,
                        title: AppLocalizations.of(context)!.lblOrders,
                      ),
                    ),
                    getSpaceWidth(AppConstants.pagePadding),
                    InkWell(
                      onTap: () {
                        bottomNavCtx.read<BottomNavCubit>().selectItem(4);
                      },
                      child: BottomBarItem(
                        image: "setting.svg",
                        isSelected:
                            bottomNavCtx.read<BottomNavCubit>().selectedIndex ==
                                4,
                        title: AppLocalizations.of(context)!.lblSetting,
                      ),
                    ),
                  ],
                ),
              )),
          body: Center(
            child: widgetOptions
                .elementAt(bottomNavCtx.read<BottomNavCubit>().selectedIndex),
          ),
        );
      },
    );
  }
}
