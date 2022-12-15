import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Presentation/Routes/route_names.dart';
import '../../features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import '../Constants/Enums/exception_enums.dart';
import 'shared_texts.dart';


/// Hide Keyboard
void hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

checkUserAuth(
    {required BuildContext context,
      required CustomStatusCodeErrorType errorType}) {
  if (errorType == CustomStatusCodeErrorType.unVerified) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.logOut();

    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.loginHomePageRoute, (route) => false);
  }
}


/// Calculate %
String calculatePercentage(String price, String discount) {
  String percent = ((double.parse(discount) * double.parse(price)) / (100))
      .toStringAsFixed(2);

  return percent;
}

/// Calculate Total Price
String calculateTotalPrice(String price, String discount) {
  String finalPrice =
      (double.parse(price) - double.parse(calculatePercentage(price, discount)))
          .toStringAsFixed(2);

  return finalPrice;
}

/// Get Widget Height
double getWidgetHeight(double height) {
  double currentHeight = SharedText.screenHeight * (height / 812);
  return currentHeight;
}

/// Get Widget Width
double getWidgetWidth(double width) {
  double currentWidth = SharedText.screenWidth * (width / 375);
  return currentWidth;
}

/// Get Space Height
SizedBox getSpaceHeight(double height) {
  double currentHeight = SharedText.screenHeight * (height / 812);
  return SizedBox(height: currentHeight);
}

/// Get Space Width
SizedBox getSpaceWidth(double width) {
  double currentWidth = SharedText.screenWidth * (width / 375);
  return SizedBox(width: currentWidth);
}
