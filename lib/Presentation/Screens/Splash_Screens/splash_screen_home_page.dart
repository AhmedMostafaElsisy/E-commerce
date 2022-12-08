import 'dart:async';
import 'dart:convert';
import 'package:captien_omda_customer/Presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_asset_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/Constants/app_constants.dart';
import '../../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../Data/local_source/flutter_secured_storage.dart';
import '../../../core/Helpers/shared_texts.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  Future goToNextPage() async {
    await DefaultSecuredStorage.getAccessToken().then((value) async {
      if (value != null && value.isNotEmpty) {
        DioHelper.dio.options.headers
            .addAll({"Authorization": "Bearer $value"});
        await DefaultSecuredStorage.getUserMap().then((value) {
          SharedText.currentUser = UserBaseEntity.fromJson(json.decode(value!));
          Timer(
              const Duration(milliseconds: 2500),
              () => Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.homePageRoute, (route) => false));
        });
      } else {
        Timer(
            const Duration(milliseconds: 2500),
            () => Navigator.pushReplacementNamed(
                context, RouteNames.loginHomePageRoute));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backGroundColor,
      body: Center(
        child: SizedBox(
          width: SharedText.screenWidth,
          height: SharedText.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonAssetImageWidget(
                imageString: "splash_logo.png",
                height: 250,
                width: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
