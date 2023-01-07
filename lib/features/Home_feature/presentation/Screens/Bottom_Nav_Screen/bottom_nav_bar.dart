import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../Setting_feature/presentation/setting_screen.dart';
import '../../logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../../logic/Bottom_Nav_Cubit/bottom_nav_cubit_state.dart';
import '../Home_Screens/home_page.dart';
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
      HomePage(),
      HomePage(),
      HomePage(),
      SettingScreen(),
    ];

    return BlocConsumer<BottomNavCubit, BottomNavCubitState>(
      listener: (bottomNavCtx, bottomNavState) {},
      builder: (bottomNavCtx, bottomNavState) {
        return Scaffold(
          backgroundColor: AppConstants.lightWhiteColor,
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
                        color: AppConstants.lightShadowSecColor.withOpacity(0.16),
                        blurRadius: 4,
                        offset: const Offset(0, 0))
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getWidgetHeight(AppConstants.smallPadding)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///home icon
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

                    ///Shop icon
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
