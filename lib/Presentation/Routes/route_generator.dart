import 'package:default_repo_app/Presentation/Routes/route_argument_model.dart';
import 'package:default_repo_app/Presentation/Screens/Splash_Screens/splash_screen_home_page.dart';
import 'package:flutter/material.dart';
import '../../features/Auth_feature/Presentation/login_home_page.dart';
import '../Screens/Forget_Password_Screen/forget_password_screen.dart';
import '../Screens/Forget_Password_Screen/new_password_screen.dart';
import '../Screens/Home_Screens/home_page.dart';
import '../Screens/Notification_Screen/notification_screen.dart';
import '../Screens/Sign_Up_Screen/sign_up_screen.dart';
import '../Screens/Splash_Screens/choose_login_or_signup.dart';
import '../Screens/Verification_Code_Screen/verification_code_screen.dart';
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
      case RouteNames.chooseLoginSignupScreenRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const ChooseLoginSignupScreen());
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

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
