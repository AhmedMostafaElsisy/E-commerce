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
      decoration: const BoxDecoration(
        color: AppConstants.lightWhiteColor,
        image: DecorationImage(
            image: AssetImage(
              "assets/images/backGround.png",
            ),
            fit: BoxFit.fill),
      ),
      child: screenContent,
    );
  }
}
