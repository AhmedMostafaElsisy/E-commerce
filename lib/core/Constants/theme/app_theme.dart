import 'package:flutter/material.dart';

import '../app_constants.dart';

ThemeData lightTheme = ThemeData(
  /// Font Family
  fontFamily: 'Cairo',
  visualDensity: VisualDensity.adaptivePlatformDensity,

  /// Colors
  scaffoldBackgroundColor: AppConstants.lightGrayBackgroundColor,
  primaryColor: AppConstants.lightWhiteColor,
  hintColor: AppConstants.lightGreyColor,
  dividerColor: Colors.transparent,
  focusColor: AppConstants.lightGreyColor,
  shadowColor: AppConstants.lightShadowColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0, foregroundColor: AppConstants.mainColor),

  /// Brightness
  brightness: Brightness.light,

  /// Text Themes
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: AppConstants.xxSmallFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightTextColor,
        height: 1.3),
    headline2: TextStyle(
        fontSize: AppConstants.smallFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightTextColor,
        height: 1.3),
    headline3: TextStyle(
        fontSize: AppConstants.normalFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightTextColor,
        height: 1.3),
    headline4: TextStyle(
        fontSize: AppConstants.mediumFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightTextColor,
        height: 1.3),
    headline5: TextStyle(
        fontSize: AppConstants.largeFontSize,
        fontWeight: FontWeight.w700,
        color: AppConstants.lightTextColor,
        height: 1.3),
    headline6: TextStyle(
        fontSize: AppConstants.xLargeFontSize,
        fontWeight: FontWeight.w700,
        color: AppConstants.lightTextColor,
        height: 1.3),
    subtitle1: TextStyle(
        fontSize: AppConstants.smallFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    subtitle2: TextStyle(
        fontSize: AppConstants.mediumFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    caption: TextStyle(
        fontSize: AppConstants.normalFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightTextColor,
        height: 1.2),
  ),
);

ThemeData darkTheme = ThemeData(
  /// Font Family
  fontFamily: 'Montserrat',
  visualDensity: VisualDensity.adaptivePlatformDensity,

  /// Colors
  scaffoldBackgroundColor: AppConstants.lightBlackColor,
  primaryColor: AppConstants.darkBackgroundWidgetsColor,
  hintColor: AppConstants.lightGreyColor,
  dividerColor: Colors.transparent,
  shadowColor: AppConstants.lightShadowColor,

  /// Brightness
  brightness: Brightness.dark,

  /// Text Themes
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: AppConstants.xxSmallFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headline2: TextStyle(
        fontSize: AppConstants.smallFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headline3: TextStyle(
        fontSize: AppConstants.normalFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headline4: TextStyle(
        fontSize: AppConstants.mediumFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headline5: TextStyle(
        fontSize: AppConstants.largeFontSize,
        fontWeight: FontWeight.w700,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    headline6: TextStyle(
        fontSize: AppConstants.xLargeFontSize,
        fontWeight: FontWeight.w700,
        color: AppConstants.darkOffWhiteColor,
        height: 1.3),
    subtitle1: TextStyle(
        fontSize: AppConstants.smallFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    subtitle2: TextStyle(
        fontSize: AppConstants.mediumFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.3),
    caption: TextStyle(
        fontSize: AppConstants.normalFontSize,
        fontWeight: FontWeight.w500,
        color: AppConstants.lightGreyColor,
        height: 1.2),
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppConstants.mainColor),
);
