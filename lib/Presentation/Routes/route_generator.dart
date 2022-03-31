
import 'package:default_repo_app/Presentation/Screens/Login_Screens/login_home_page.dart';
import 'package:default_repo_app/Presentation/Screens/Splash_Screens/splash_screen_home_page.dart';
import 'package:flutter/material.dart';

import 'route_animation.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.splashPageRoute:
        return MaterialPageRoute(builder: (_) => const SplashHomePage());
      case RouteNames.loginHomePageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const LoginHomePage());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
