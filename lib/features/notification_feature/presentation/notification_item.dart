import 'package:flutter/material.dart';

import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import '../domain/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel model;

  const NotificationItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getWidgetHeight(16), horizontal: getWidgetWidth(16)),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppConstants.lightBlackColor.withOpacity(0.15),
              offset: const Offset(0, 1),
              blurRadius: 3,
              spreadRadius: -1)
        ],
        color: model.isRead!
            ? AppConstants.lightWhiteColor
            : AppConstants.verificationCodeColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: getWidgetWidth(48),
                height: getWidgetHeight(48),
                decoration: BoxDecoration(
                    border: Border.all(color: AppConstants.mainColor, width: 1),
                    color: AppConstants.verificationCodeColor),
                child: commonCachedImageWidget(
                  model.icon ??
                      "https://www.seekpng.com/png/detail/110-1100707_person-avatar-placeholder.png",
                  width: 48,
                  height: 48,
                  radius: AppConstants.smallRadius,
                  fit: BoxFit.fill,
                ),
              ),

              /// Space
              getSpaceWidth(8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Status
                  CommonTitleText(
                    textKey: model.title ?? "Order Status",
                    textWeight: FontWeight.w400,
                    textFontSize: AppConstants.smallFontSize,
                    textColor: model.isRead!
                        ? AppConstants.lightBlackColor
                        : AppConstants.mainColor,
                  ),

                  /// Space
                  getSpaceHeight(4),

                  /// Description
                  CommonTitleText(
                    textKey: model.description ??
                        "your request Electrical Service  #elec_004  time out",
                    textWeight: FontWeight.w400,
                    lines: 2,
                    textFontSize: AppConstants.smallFontSize - 2,
                    textColor: model.isRead!
                        ? AppConstants.mainTextColor
                        : AppConstants.lightBlackColor,
                  ),

                  /// Space
                  getSpaceHeight(4),

                  /// Time
                  CommonTitleText(
                    textKey: model.createdAt ?? "8 hrs ago",
                    textWeight: FontWeight.w400,
                    textFontSize: AppConstants.xxSmallFontSize,
                    textColor: AppConstants.lightGrayShadowColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
