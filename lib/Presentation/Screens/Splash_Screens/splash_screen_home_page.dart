import 'dart:async';
import 'dart:convert';
import 'package:default_repo_app/Presentation/Routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../../core/Constants/app_constants.dart';
import '../../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../Data/local_source/flutter_secured_storage.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../Widgets/common_asset_svg_image_widget.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  Future goToNextPage() async {
    await DefaultSecuredStorage.getAccessToken().then((value) async {
      if (value != null && value.isNotEmpty) {
        DioHelper.dio.options.headers
            .addAll({"Authorization": "Bearer $value"});
        await DefaultSecuredStorage.getUserMap().then((value) {
          SharedText.currentUser = UserBaseEntity.fromJson(json.decode(value!));
          Timer(
              const Duration(milliseconds: 2500),
              () => Navigator.pushNamedAndRemoveUntil(context,
                  RouteNames.homePageRoute, (route) => false));
        });
      } else {
        Timer(
            const Duration(milliseconds: 2500),
            () => Navigator.pushReplacementNamed(
                context, RouteNames.chooseLoginSignupScreenRoute));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
        setState(() {});
      });

    controller.forward();

    goToNextPage();
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      body: Center(
        child: SizedBox(
          width: SharedText.screenWidth,
          height: SharedText.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonAssetSvgImageWidget(
                imageString: "splash_logo.svg",
                height: 200,
                width: 200,
              ),
              getSpaceHeight(56),
              Container(
                color: Colors.transparent,
                width: getWidgetWidth(238),
                height: getWidgetHeight(12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppConstants.borderRadius)),
                  child: LinearProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                    backgroundColor: AppConstants.lightWhiteColor,
                    color: AppConstants.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
