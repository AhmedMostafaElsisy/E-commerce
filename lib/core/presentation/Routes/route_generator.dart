import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/Auth_feature/Presentation/screens/splash_screen_home_page.dart';
import 'package:flutter/material.dart';

import '../../../features/Auth_feature/Presentation/screens/chanage_password_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/choose_login_or_signup.dart';
import '../../../features/Auth_feature/Presentation/screens/forget_password_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/login_home_page.dart';
import '../../../features/Auth_feature/Presentation/screens/new_password_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/sign_up_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/verification_code_screen.dart';
import '../../../features/Home_feature/presentation/Screens/Bottom_Nav_Screen/bottom_nav_bar.dart';
import '../../../features/Home_feature/presentation/Screens/Home_Screens/home_page.dart';
import '../../../features/Profile_feature/presentation/screens/edit_profile_screen.dart';
import '../../../features/Profile_feature/presentation/screens/profile_screen.dart';
import '../../../features/favorite_feature/presentation/screen/favorite_list_screen.dart';
import '../../../features/notification_feature/presentation/notification_screen.dart';
import '../../../features/rating_feature/presentation/screen/rating_screen.dart';
import '../../../features/store_feature/presentation/screen/add_store_screen.dart';
import '../../../features/store_feature/presentation/screen/edit_store_screen.dart';
import '../../../features/store_feature/presentation/screen/my_store_screen.dart';
import 'route_animation.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.splashPageRoute:
        return MaterialPageRoute(builder: (_) => const SplashHomePage());
      case RouteNames.chooseLoginSignupScreenRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const ChooseLoginSignupScreen());
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
      case RouteNames.changePasswordPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const ChangePasswordScreen());
      case RouteNames.editProfilePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const EditProfileScreen());
      case RouteNames.ratingPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: RatingScreen(routeArgument: args as RouteArgument));
      case RouteNames.favoritePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const FavoriteListScreen());
      case RouteNames.myStoresPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const MyStoresListScreen());
      case RouteNames.addStoresPageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const AddStoreScreen());
      case RouteNames.editStoresPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: EditStoreScreen(argument: args as RouteArgument));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
