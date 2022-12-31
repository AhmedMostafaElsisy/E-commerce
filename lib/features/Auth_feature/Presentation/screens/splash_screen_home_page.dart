import 'dart:async';
import 'package:captien_omda_customer/features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../logic/Login_Cubit/login_states.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  late LoginCubit loginCubit;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.startApp();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
      setState(() {});
    });
    controller.forward();

  }
  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backGroundColor,
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (loginCtx, loginState) {
          if (loginState is LoginSuccess) {
            Timer(
                const Duration(milliseconds: 2500),
                () => Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.mainBottomNavPageRoute, (route) => false));
          } else if (loginState is LoginFailed) {
            Timer(
                const Duration(milliseconds: 2500),
                () => Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.chooseLoginSignupScreenRoute, (route) => false));
          }
        },
        builder: (loginCtx, loginState) {
          return Container(
            width: SharedText.screenWidth,
            height: SharedText.screenHeight,
            decoration:  BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/backGround.png",
                    ),
                    fit: BoxFit.fill) ,  gradient: LinearGradient(
            colors: [
            AppConstants.lightWhiteColor.withOpacity(0.28),
            AppConstants.lightWhiteColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),),
            child: Center(
              child: SizedBox(
                width: SharedText.screenWidth,
                height: SharedText.screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    commonAssetImageWidget(
                      imageString: "splash_logo.png",
                      height: 160,
                      width: 125,
                    ),
                    getSpaceHeight(40),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        color:AppConstants.loaderBackGroundColor,
                        width: getWidgetWidth(238),
                        height: getWidgetHeight(8),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
