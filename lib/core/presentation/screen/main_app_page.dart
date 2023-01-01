import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';
import '../../Helpers/shared_texts.dart';

class MainAppPage extends StatelessWidget {
  final Widget screenContent;

  const MainAppPage({Key? key, required this.screenContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SharedText.screenWidth,
      height: SharedText.screenHeight,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(
              "assets/images/backGround.png",
            ),
            fit: BoxFit.fill),
        gradient: LinearGradient(
          colors: [
            AppConstants.lightWhiteColor.withOpacity(0.28),
            AppConstants.lightWhiteColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: screenContent,
    );
  }
}
