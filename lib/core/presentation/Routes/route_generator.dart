import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/Auth_feature/Presentation/screens/splash_screen_home_page.dart';
import 'package:captien_omda_customer/features/general_prodcut_feature/presentation/screen/filter_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/Auth_feature/Presentation/screens/chanage_password_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/choose_login_or_signup.dart';
import '../../../features/Auth_feature/Presentation/screens/forget_password_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/login_home_page.dart';
import '../../../features/Auth_feature/Presentation/screens/new_password_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/sign_up_screen.dart';
import '../../../features/Auth_feature/Presentation/screens/verification_code_screen.dart';
import '../../../features/Contact_feature/Presentaion/screen/add_contact_screen.dart';
import '../../../features/Home_feature/presentation/Screens/Bottom_Nav_Screen/bottom_nav_bar.dart';
import '../../../features/Home_feature/presentation/Screens/Home_Screens/home_screen.dart';
import '../../../features/Profile_feature/presentation/screens/edit_profile_screen.dart';
import '../../../features/Profile_feature/presentation/screens/profile_screen.dart';
import '../../../features/edit_product_feature/presentation/edit_my_product_screen.dart';
import '../../../features/favorite_feature/presentation/screen/favorite_list_screen.dart';
import '../../../features/general_prodcut_feature/presentation/screen/general_product_details_screen.dart';
import '../../../features/general_prodcut_feature/presentation/screen/product_list_screen.dart';
import '../../../features/notification_feature/presentation/notification_screen.dart';
import '../../../features/order_feature/presentation/customer_order_screen.dart';
import '../../../features/order_feature/presentation/my_order_screen.dart';
import '../../../features/order_feature/presentation/order_details_screen.dart';
import '../../../features/plans_feature/presentation/screen/plans_screen.dart';
import '../../../features/rating_feature/presentation/screen/rating_list_screen.dart';
import '../../../features/store_feature/presentation/screen/add_store_screen.dart';
import '../../../features/store_feature/presentation/screen/edit_store_screen.dart';
import '../../../features/store_feature/presentation/screen/my_store_screen.dart';
import '../../../features/store_feature/presentation/screen/store_details_screen.dart';
import '../../../features/store_feature/presentation/screen/view_my_store_screen.dart';
import '../../../features/store_product/presentation/add_new_product_screen.dart';
import '../../../features/store_product/presentation/show_product_details_screen.dart';
import '../../setting_feature/presentation/terms_and_conditions_screen.dart';
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
            .animationFromCenterRightToCenterLeft(page: const HomeScreen());
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
      case RouteNames.favoritePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const FavoriteListScreen());
      case RouteNames.myStoresPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const MyStoresListScreen());
      case RouteNames.addStoresPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: AddStoreScreen(
          argument: args as RouteArgument,
        ));
      case RouteNames.editStoresPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: EditStoreScreen(argument: args as RouteArgument));
      case RouteNames.viewMyStoresPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: ViewMyStoreScreen(argument: args as RouteArgument));
      case RouteNames.addNewProductPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: AddProductScreen(argument: args as RouteArgument));
      case RouteNames.editProductPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: EditProductScreen(argument: args as RouteArgument));
      case RouteNames.showProductPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: ShowProductDetailsScreen(argument: args as RouteArgument));
      case RouteNames.myOrderPageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const MyOrderScreen());
      case RouteNames.orderDetailsPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: OrderDetailsScreen(argument: args as RouteArgument));
      case RouteNames.planPageRoute:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const PlansScreen());
      case RouteNames.productWithFilterScreen:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const ProductListScreen());
      case RouteNames.generalProductDetailsScreen:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: GeneralProductDetailsScreen(
          argument: args as RouteArgument,
        ));
      case RouteNames.filterScreen:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const FilterScreen());
      case RouteNames.storeDetailsScreen:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: StoreDetailsScreen(argument: args as RouteArgument));
      case RouteNames.contactUsScreen:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const ContactScreen());
      case RouteNames.termsScreen:
        return RouteAnimation()
            .animationFromCenterRightToCenterLeft(page: const TermsScreen());
      case RouteNames.ratingListScreen:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const RatingListScreen());
        case RouteNames.customerOrderScreen:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
            page: const CustomerOrderScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
