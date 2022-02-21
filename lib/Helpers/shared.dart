import 'dart:convert';

import 'package:default_repo_app/Logic/Models/user_base_model.dart';
import 'package:flutter/material.dart';

import 'flutter_secured_storage.dart';
import 'shared_texts.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController phoneController = TextEditingController();

/// Hide Keyboard
void hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

/// Fetch Current Locales
fetchLocale() async {
  SharedText.currentLocale = await DefaultSecuredStorage.getLang() ?? 'en';
  var lang = await DefaultSecuredStorage.getLang() ?? 'en';
  var countryCode = await DefaultSecuredStorage.getCountryCode() ?? 'us';

  String userMap = await DefaultSecuredStorage.getUserMap() ?? '';
  SharedText.currentUser = UserBaseModel.fromJson(jsonDecode(userMap));
  return Locale(lang, countryCode);
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
