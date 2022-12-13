import 'dart:async';
import 'package:captien_omda_customer/Presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../logic/Login_Cubit/login_states.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  late LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.startApp();
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
                    context, RouteNames.homePageRoute, (route) => false));
          } else if (loginState is LoginFailed) {
            Timer(
                const Duration(milliseconds: 2500),
                () => Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.loginHomePageRoute, (route) => false));
          }
        },
        builder: (loginCtx, loginState) {
          return Center(
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
          );
        },
      ),
    );
  }
}
