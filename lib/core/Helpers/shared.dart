import 'dart:math';

import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import '../../features/Auth_feature/Presentation/logic/Login_Cubit/login_cubit.dart';
import '../Constants/Enums/exception_enums.dart';
import '../presentation/Routes/route_names.dart';
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

String convertToTimeLabelFromMilliseconds(
    {required int currentPosInMilliseconds}) {
  //generating the duration label
  int currentPosInHours =
      Duration(milliseconds: currentPosInMilliseconds).inHours;
  int currentPosInMinutes =
      Duration(milliseconds: currentPosInMilliseconds).inMinutes;
  int currentPosInSeconds =
      Duration(milliseconds: currentPosInMilliseconds).inSeconds;

  int rhours = currentPosInHours;
  int rminutes = currentPosInMinutes - (currentPosInHours * 60);
  int rseconds = currentPosInSeconds -
      (currentPosInMinutes * 60 + currentPosInHours * 60 * 60);
  return "$rhours:$rminutes:$rseconds";
}

String getRecordFileRandomName() {
  return 'tau_file_${Random().nextInt(12000)}_${Random().nextInt(12000)}.aac';
}

Future<bool> checkPermissionOfMicroPhone() async {
  if (!await Permission.microphone.isGranted) {
    PermissionStatus status =
        await Permission.microphone.request().catchError((onErro) {
      debugPrint("we have an eror ${onErro.toString()}");
    });
    debugPrint(
        "microphone is not granted ${status != PermissionStatus.granted}");
    if (status != PermissionStatus.granted) {
      return false;
    }
  }
  return true;
}

NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

openPhotoDialog(
  BuildContext context,
  String path,
) =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: AppConstants.transparent,
          child: Container(
              color: AppConstants.transparent,
              child: Stack(
                children: [
                  PhotoView(
                    backgroundDecoration: BoxDecoration(
                      color: AppConstants.transparent,
                    ),
                    enableRotation: false,
                    heroAttributes:
                        const PhotoViewHeroAttributes(tag: "someTag"),
                    imageProvider: NetworkImage(path),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.borderInputColor,
                            border: Border.all(color: AppConstants.greyColor)),
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Icon(Icons.close_outlined,
                              color: AppConstants.lightWhiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
