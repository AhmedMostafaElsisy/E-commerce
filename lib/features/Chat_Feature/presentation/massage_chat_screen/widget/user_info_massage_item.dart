import 'package:flutter/material.dart';

import '../../../../../core/Constants/Enums/chat/chat_card_types.dart';
import '../../../../../core/Constants/Enums/chat/who_start_call_types.dart';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../Data/chat_models/chat_user_model.dart';

class UserInfoMassageItem extends StatelessWidget {
  final bool isOnline;
  final int messageUnReadCount;
  final ChatUserModel model;
  final ChatCardType cardType;
  final WhoStartCall whoStartCall;

  const UserInfoMassageItem({
    Key? key,
    required this.isOnline,
    this.messageUnReadCount = 0,
    required this.model,
    required this.cardType,
    this.whoStartCall = WhoStartCall.init,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Stack(
            children: [
              commonCachedImageWidget(
                model.image ?? "",
                height: 48,
                width: 48,
                isCircular: true,
                radius: 1000,
                fit: BoxFit.fill,
              ),
              if (cardType != ChatCardType.calls)

                ///Todo : add the flag for online user
                if (isOnline)
                  Positioned(
                    top: getWidgetHeight(40),
                    right: getWidgetWidth(30),
                    child: Container(
                      width: getWidgetHeight(8),
                      height: getWidgetHeight(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppConstants.lightWhiteColor, width: 1),
                          shape: BoxShape.circle,
                          color: AppConstants.onlineGreenColor),
                    ),
                  )
            ],
          ),
          getSpaceWidth(AppConstants.smallRadius),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitleText(
                textKey: model.name + " " + (model.lastName ?? ""),
                textColor: AppConstants.mainColor,
                textFontSize: AppConstants.smallFontSize,
                textWeight: FontWeight.w600,
              ),
              getSpaceHeight(AppConstants.containerBorderRadius),
              if (cardType != ChatCardType.calls) ...[
                SizedBox(
                  width: getWidgetWidth(200),
                  child: CommonTitleText(
                    textKey: model.getMessageDependOnType(),
                    textColor: AppConstants.chatTextColor,
                    textAlignment: TextAlign.start,
                    textFontSize: AppConstants.xxSmallFontSize,
                    minTextFontSize: AppConstants.xxSmallFontSize,
                    textWeight: FontWeight.w400,
                  ),
                ),
              ] else ...[
                SizedBox(
                  width: getWidgetWidth(200),
                  child: Row(
                    children: [
                      CommonAssetSvgImageWidget(
                        imageString: whoStartCall == WhoStartCall.me
                            ? "out_call.svg"
                            : "in_call.svg",
                        height: 16,
                        width: 16,
                        fit: BoxFit.fill,
                      ),
                      const CommonTitleText(
                        textKey: "قبل ١٤ دقيقة",
                        textColor: AppConstants.chatTextColor,
                        textFontSize: AppConstants.xxSmallFontSize,
                        minTextFontSize: AppConstants.xxSmallFontSize,
                        textWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          )
        ],
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (cardType != ChatCardType.calls) ...[
              ///todo : add user massage not read
              if (messageUnReadCount > 0)
                Container(
                  width: getWidgetHeight(20),
                  height: getWidgetHeight(20),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppConstants.mainColor),
                  child: Center(
                    child: CommonTitleText(
                      textKey: messageUnReadCount.toString(),
                      textWeight: FontWeight.w700,
                      textFontSize: AppConstants.xxSmallFontSize,
                      textColor: AppConstants.lightWhiteColor,
                    ),
                  ),
                ),
              getSpaceHeight(AppConstants.containerBorderRadius),
              CommonTitleText(
                textKey: model.lastMessage?.dateOfCreation ?? "---",
                textColor: AppConstants.mainTextColor,
                textFontSize: AppConstants.xxSmallFontSize,
                textWeight: FontWeight.w400,
              ),
            ] else ...[
              Container(
                width: getWidgetWidth(32),
                height: getWidgetHeight(32),
                decoration: BoxDecoration(
                    color: AppConstants.lightBorderColor,
                    borderRadius: BorderRadius.circular(
                        AppConstants.containerOfListTitleBorderRadius)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CommonAssetSvgImageWidget(
                    imageString: whoStartCall == WhoStartCall.me
                        ? "call.svg"
                        : "video.svg",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ]
          ],
        ),
      )
    ]);
  }
}
