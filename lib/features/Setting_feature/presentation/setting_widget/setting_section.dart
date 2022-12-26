import 'package:flutter/cupertino.dart';

import '../../../../core/Constants/app_constants.dart';

class SettingSection extends StatelessWidget {
  final Widget sectionContent;
  const SettingSection({Key? key,required this.sectionContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: AppConstants.lightWhiteColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(
                AppConstants.containerOfListTitleBorderRadius),
            topLeft: Radius.circular(
                AppConstants.containerOfListTitleBorderRadius),
          ),
          boxShadow: [
            BoxShadow(
                color: AppConstants.redShadowColor
                    .withOpacity(0.16),
                blurRadius: 4,
                offset: const Offset(0, 0))
          ]),
      child:sectionContent ,
    );
  }
}
