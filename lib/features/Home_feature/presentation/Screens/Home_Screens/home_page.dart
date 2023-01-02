import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_app_bar_icon_with_counter.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/screens/app_main_screen.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/request_cubit/request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/setting_feature/Logic/setting_cubit.dart';
import '../../../../trip_feature/logic/trip_cubit/trip_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RequestCubit requestCubit;
  late TripCubit tripCubit;
  late SettingCubit settingCubit;

  @override
  void initState() {
    super.initState();
    requestCubit = BlocProvider.of<RequestCubit>(context);
    settingCubit = BlocProvider.of<SettingCubit>(context);
    tripCubit = BlocProvider.of<TripCubit>(context);
    settingCubit.getSetting();
    tripCubit.getCurrentRequest();
  }

  @override
  Widget build(BuildContext context) {
    return AppMainScreen(
      screen: Scaffold(
          backgroundColor: AppConstants.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getWidgetHeight(32),
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
            children: [
              ///Spacer
              getSpaceHeight(50),
            ],
          )),
    );
  }
}
