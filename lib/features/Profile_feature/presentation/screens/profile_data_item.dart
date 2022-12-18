import 'package:flutter/cupertino.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';


class ProfileDataItem extends StatelessWidget {
  final String image;
  final String title;
  final String data;
  final bool? isLastItem;

  const ProfileDataItem(
      {Key? key,
      required this.data,
      required this.title,
      required this.image,
       this.isLastItem=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(

            children: [
              CommonAssetSvgImageWidget(
                  imageString: image,
                  width: 22,
                  height: 22,
                  fit:  BoxFit.cover,
                ),
              getSpaceWidth(8),
              CommonTitleText(
                textKey: title,
                textFontSize: AppConstants.smallFontSize,
                textColor: AppConstants.lightBlackColor,
                textWeight: FontWeight.w600,
              ),

            ],
          ),
          getSpaceHeight(8),
          Row(
            children: [
              getSpaceWidth(24),
              CommonTitleText(
                textKey: data,
                textFontSize: AppConstants.smallFontSize,
                textColor: AppConstants.mainTextColor,
                textWeight: FontWeight.w400,
              ),
            ],
          ),
          if(!isLastItem!)...[
            getSpaceHeight(8),
            Container(
              height: getWidgetHeight(1),
              width: getWidgetWidth(343),
              color: AppConstants.lightSecondShadowColor,
            )
          ]

        ],
      ),
    );
  }
}
