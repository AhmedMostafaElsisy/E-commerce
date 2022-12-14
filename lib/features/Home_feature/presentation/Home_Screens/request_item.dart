import 'package:flutter/material.dart';
import '../../../../Presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../Presentation/Widgets/common_title_text.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestItemWidget extends StatelessWidget {
  final String mainTitle;
  final String subTitle;
  final Function() onReorderClick;

  const RequestItemWidget(
      {Key? key,
      required this.mainTitle,
      required this.onReorderClick,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const commonAssetSvgImageWidget(
          imageString: "history.svg",
          height: 24,
          width: 24,
          fit: BoxFit.contain,
        ),
        getSpaceWidth(AppConstants.smallPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getWidgetWidth(220),
                height: getWidgetHeight(17),
                child: CommonTitleText(
                  textKey: mainTitle,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.smallFontSize,
                  minTextFontSize: AppConstants.smallFontSize,
                  textAlignment: TextAlign.start,
                ),
              ),
              getSpaceHeight(AppConstants.smallPadding),
              SizedBox(
                width: getWidgetWidth(220),
                height: getWidgetHeight(17),
                child: CommonTitleText(
                  textKey: subTitle,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.smallFontSize,
                  minTextFontSize: AppConstants.smallFontSize,
                  textAlignment: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              onReorderClick();
            },
            child: CommonTitleText(
              textKey: AppLocalizations.of(context)!.lblReorder,
              textColor: AppConstants.lightBlueColor,
              textWeight: FontWeight.w500,
              textFontSize: AppConstants.smallFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
