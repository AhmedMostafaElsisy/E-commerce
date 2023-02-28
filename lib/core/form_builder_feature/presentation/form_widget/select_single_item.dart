import 'package:flutter/material.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../Helpers/shared_texts.dart';
import '../../../presentation/Widgets/common_title_text.dart';

class PopUpSingleItem extends StatelessWidget {
  final String name;
  final bool isSelected;

  const PopUpSingleItem(
      {Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(47),
      width: SharedText.screenWidth,

      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(13),
          horizontal: getWidgetWidth(AppConstants.pagePadding)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CommonTitleText(
          textKey: name,
          textWeight: FontWeight.w600,
          textColor: AppConstants.lightBlackColor,
          textFontSize: AppConstants.mediumFontSize,
        ),

         Container(
           height: getWidgetHeight(20),
           width: getWidgetHeight(20),
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             border: Border.all(color: AppConstants.mainColor),
             color: AppConstants.lightWhiteColor
           ),
           child:isSelected?  Padding(
             padding: const EdgeInsets.all(2.0),
             child: Container(
               height: getWidgetHeight(14),
               width: getWidgetHeight(1),
               decoration: const BoxDecoration(
                   shape: BoxShape.circle,
                   color: AppConstants.mainColor
               ),
             ),
           ):const SizedBox(),
         ),
      ]),
    );
  }
}
