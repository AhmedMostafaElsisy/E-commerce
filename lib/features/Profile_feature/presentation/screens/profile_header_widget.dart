import 'package:flutter/cupertino.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared_texts.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SharedText.screenWidth,
      height: (140),
      decoration: const BoxDecoration(
          color: AppConstants.mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppConstants.containerBorderRadius),
            bottomRight: Radius.circular(AppConstants.containerBorderRadius),
          )),
    );
  }
}
