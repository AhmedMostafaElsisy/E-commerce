import 'package:captien_omda_customer/Presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/Auth_feature/Presentation/screens/splash_screen_home_page.dart';
import 'package:flutter/material.dart';
import '../../features/Auth_feature/Presentation/screens/login_home_page.dart';
import '../../features/Auth_feature/Presentation/screens/sign_up_screen.dart';
import '../../features/Auth_feature/Presentation/screens/verification_code_screen.dart';
import '../../features/Auth_feature/Presentation/screens/forget_password_screen.dart';

import '../../features/Home_feature/presentation/Screens/Bottom_Nav_Screen/bottom_nav_bar.dart';
import '../../features/Home_feature/presentation/Screens/Home_Screens/home_page.dart';
import '../../features/Profile_feature/presentation/screens/profile_screen.dart';
import '../Screens/Forget_Password_Screen/new_password_screen.dart';
import '../Screens/Notification_Screen/notification_screen.dart';
import 'route_animation.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.splashPageRoute:
        return MaterialPageRoute(builder: (_) => const SplashHomePage());
      case RouteNames.homePageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const HomePage());
      case RouteNames.loginHomePageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const LoginHomePage());
      case RouteNames.singUpPageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const SignUpPage());
      case RouteNames.forgetPasswordPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const ForgetPasswordScreen());
      case RouteNames.newPasswordPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: NewPasswordScreen(argument: args as RouteArgument));
      case RouteNames.verificationCodePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: VerificationCodeScreen(routeArgument: args as RouteArgument));
      case RouteNames.notificationPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const NotificationListScreen());
      case RouteNames.mainBottomNavPageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const BottomNavBar());
        case RouteNames.profilePageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const ProfileScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
