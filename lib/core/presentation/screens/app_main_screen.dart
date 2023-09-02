import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppMainScreen extends StatelessWidget {
  final Widget screen;

  const AppMainScreen({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            "assets/images/backGround.png",
          ),
          fit: BoxFit.fill,
        ),
        gradient: LinearGradient(
          colors: [
            AppConstants.lightWhiteColor.withOpacity(0.28),
            AppConstants.lightWhiteColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: screen,
    );
  }
}
