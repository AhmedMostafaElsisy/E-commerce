import 'dart:async';
import 'package:default_repo_app/Presentation/Routes/route_names.dart';
import 'package:default_repo_app/Presentation/Screens/App_Main_Page/app_main_page.dart';
import 'package:default_repo_app/Presentation/Widgets/Loader_Widgets/scale_transition_loader_widget.dart';
import 'package:flutter/material.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  Future goToHomePage() async {
    Timer(
        const Duration(milliseconds: 10000),
        () => Navigator.pushReplacementNamed(
            context, RouteNames.loginHomePageRoute));
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOutCirc);

    controller!.forward();
    goToHomePage();
  }

  @override
  dispose() {
    controller!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const AppMainPage(
      pageContent: ScaleTransitionAnimation(),
      // pageContent: Center(
      //   child: Material(
      //     color: Colors.transparent,
      //     child: ScaleTransition(
      //       scale: scaleAnimation!,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Image.asset('assets/images/splash.png',
      //               fit: BoxFit.contain,
      //               height: getWidgetHeight(78),
      //               width: getWidgetWidth(237)),
      //           getSpaceHeight(getWidgetHeight(90.86)),
      //           Text(AppLocalizations.of(context)!.title),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
