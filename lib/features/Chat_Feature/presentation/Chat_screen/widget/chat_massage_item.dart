import 'package:captien_omda_customer/features/Chat_Feature/presentation/Chat_screen/widget/video_item.dart';
import 'package:captien_omda_customer/features/Chat_Feature/presentation/Chat_screen/widget/voice_massage_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/Constants/Enums/chat/massage_type.dart';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../Data/chat_models/chat_model.dart';
import '../attchment_pop_up/image_pop_up.dart';
import '../attchment_pop_up/video_pop_up.dart';
import 'chat_time_and_seen_widget.dart';

class ChatMassageItem extends StatelessWidget {
  final bool isMe;
  final ChatMassageModel model;

  const ChatMassageItem({Key? key, required this.isMe, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(Uri.parse(model.massageContent!).toString());
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        ///text send
        if (model.massageType == MassageType.text) ...[
          Container(
            padding: EdgeInsets.symmetric(
                vertical: getWidgetHeight(AppConstants.smallPadding),
                horizontal: getWidgetWidth(AppConstants.smallPadding)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  AppConstants.containerOfListTitleBorderRadius),
              color:
                  isMe ? AppConstants.mainColor : AppConstants.lightBlueColor,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: getWidgetWidth(50),
                    maxWidth: getWidgetWidth(200),
                  ),
                  child: CommonTitleText(
                    textKey: model.massageContent!,
                    textColor: isMe
                        ? AppConstants.lightWhiteColor
                        : AppConstants.lightBlackColor,
                    textFontSize: AppConstants.smallFontSize,
                    minTextFontSize: AppConstants.smallFontSize,
                    textWeight: FontWeight.w500,
                    lines: 50,
                    textAlignment: isMe ? TextAlign.start : TextAlign.end,
                  ),
                ),
                getSpaceHeight(
                  AppConstants.smallPadding,
                ),
                ChatTimeAndSeenWidget(
                  isMe: isMe,
                  isSeen: model.isSeen!,
                  dateOfCreation: model.dateOfCreation!,
                ),
              ],
            ),
          ),
        ]

        ///image send
        else if (model.massageType == MassageType.image) ...[
          InkWell(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) => imageDialog(
                      context,
                      model.isLocal!
                          ? model.massageContent!
                          : model.attachment!,
                      isFile: model.isLocal!));
            },
            child: Container(
              width: getWidgetWidth(220),
              padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(AppConstants.smallPadding),
                  horizontal: getWidgetWidth(AppConstants.smallPadding)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    AppConstants.containerOfListTitleBorderRadius),
                color:
                    isMe ? AppConstants.mainColor : AppConstants.lightBlueColor,
              ),
              child: SizedBox(
                width: getWidgetWidth(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    model.isLocal!
                        ? commonFileImageWidget(
                            imageString: model.massageContent!,
                            height: 180,
                            width: 180,
                            fit: BoxFit.fill,
                            radius:
                                AppConstants.containerOfListTitleBorderRadius,
                          )
                        : commonCachedImageWidget(
                            model.attachment!,
                            height: 180,
                            width: 180,
                            radius:
                                AppConstants.containerOfListTitleBorderRadius,
                            fit: BoxFit.fill,
                          ),
                    getSpaceHeight(
                      AppConstants.smallPadding,
                    ),
                    ChatTimeAndSeenWidget(
                      isMe: isMe,
                      isSeen: model.isSeen!,
                      dateOfCreation: model.dateOfCreation!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]

        ///docs send
        else if (model.massageType == MassageType.application) ...[
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(model.attachment!),
                  mode: LaunchMode.externalApplication);
            },
            child: Container(
              width: getWidgetWidth(90),
              padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(AppConstants.smallPadding),
                  horizontal: getWidgetWidth(AppConstants.smallPadding)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    AppConstants.containerOfListTitleBorderRadius),
                color:
                    isMe ? AppConstants.mainColor : AppConstants.lightBlueColor,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.file_copy,
                    color: isMe
                        ? AppConstants.lightBlueColor
                        : AppConstants.mainColor,
                    size: 50,
                  ),
                  getSpaceHeight(
                    AppConstants.smallPadding,
                  ),
                  ChatTimeAndSeenWidget(
                    isMe: isMe,
                    isSeen: model.isSeen!,
                    dateOfCreation: model.dateOfCreation!,
                  ),
                ],
              ),
            ),
          ),
        ]

        ///video send
        else if (model.massageType == MassageType.video) ...[
          ///Todo: open video in popup
          InkWell(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) => videoDialog(
                      context,
                      model.isLocal!
                          ? model.massageContent!
                          : model.attachment ?? "",
                      isFile: model.isLocal!));
            },
            child: Container(
              width: 245,
              padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(AppConstants.smallPadding * 5),
                  horizontal: getWidgetWidth(AppConstants.smallPadding)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    AppConstants.containerOfListTitleBorderRadius),
                color:
                    isMe ? AppConstants.mainColor : AppConstants.lightBlueColor,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  VideoPostItem(
                    canPlay: false,
                    videoUrl: model.isLocal!
                        ? model.massageContent!
                        : model.attachment ?? "",
                    isLocal: model.isLocal!,
                  ),
                  getSpaceHeight(
                    AppConstants.smallPadding,
                  ),
                  ChatTimeAndSeenWidget(
                    isMe: isMe,
                    isSeen: model.isSeen!,
                    dateOfCreation: model.dateOfCreation!,
                  ),
                ],
              ),
            ),
          ),
        ]

        ///location send
        else if (model.massageType == MassageType.location) ...[
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(model.massageContent!),
                  mode: LaunchMode.externalApplication);
            },
            child: Container(
                width: 142,
                padding: EdgeInsets.symmetric(
                    vertical: getWidgetHeight(AppConstants.smallPadding),
                    horizontal: getWidgetWidth(AppConstants.smallPadding)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      AppConstants.containerOfListTitleBorderRadius),
                  color: isMe
                      ? AppConstants.mainColor
                      : AppConstants.lightBlueColor,
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    commonAssetImageWidget(
                      imageString: "mapview.jpg",
                      height: 142,
                      width: 142,
                      radius: AppConstants.containerOfListTitleBorderRadius,
                      fit: BoxFit.cover,
                    ),
                    getSpaceHeight(
                      AppConstants.smallPadding,
                    ),
                    ChatTimeAndSeenWidget(
                      isMe: isMe,
                      isSeen: model.isSeen!,
                      dateOfCreation: model.dateOfCreation!,
                    ),
                  ],
                )),
          ),
        ]

        ///contact send
        else if (model.massageType == MassageType.contact) ...[
          // Container(
          //   width: 245,
          //   padding: EdgeInsets.symmetric(
          //       vertical: getWidgetHeight(AppConstants.smallPadding),
          //       horizontal: getWidgetWidth(AppConstants.smallPadding)),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(
          //         AppConstants.containerOfListTitleBorderRadius),
          //     color:
          //         isMe ? AppConstants.mainColor : AppConstants.lightBlueColor,
          //   ),
          //   child: InkWell(
          //     onTap: () async {
          //       if (Platform.isIOS) {
          //         await launch("tel://${Phone(
          //           model.massageContent!.split("-").last,
          //         ).number}");
          //         await Future.delayed(
          //           const Duration(seconds: 3),
          //         );
          //       } else {
          //         final Uri launchUri = Uri(
          //           scheme: 'tel',
          //           path: Phone(
          //             model.massageContent!.split("-").last,
          //           ).number,
          //         );
          //
          //         await launchUrl(launchUri);
          //         await Future.delayed(const Duration(seconds: 3));
          //       }
          //     },
          //     child: Column(
          //       crossAxisAlignment:
          //           isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          //       children: [
          //         MyContactsItem(
          //           nameWidth: 100,
          //           avatarBackGroundColor: isMe
          //               ? AppConstants.lightBlueColor
          //               : AppConstants.mainColor,
          //           avatarTextColor: isMe
          //               ? AppConstants.mainColor
          //               : AppConstants.lightBlueColor,
          //           backGroundColor: isMe
          //               ? AppConstants.mainColor
          //               : AppConstants.lightBlueColor,
          //           textColor: isMe
          //               ? AppConstants.lightWhiteColor
          //               : AppConstants.lightBlackColor,
          //           model: Contact(
          //               displayName: model.massageContent!.split("-").first,
          //               phones: [
          //                 Phone(
          //                   model.massageContent!.split("-").last,
          //                 )
          //               ]),
          //         ),
          //         getSpaceHeight(
          //           AppConstants.smallPadding,
          //         ),
          //         ChatTimeAndSeenWidget(
          //           isMe: isMe,
          //           isSeen: model.isSeen!,
          //           dateOfCreation: model.dateOfCreation!,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ]

        ///docs filed send
        else if (model.massageType == MassageType.audio) ...[
          Container(
              width: 245,
              padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(AppConstants.smallPadding),
                  horizontal: getWidgetWidth(AppConstants.smallPadding)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    AppConstants.containerOfListTitleBorderRadius),
                color:
                    isMe ? AppConstants.mainColor : AppConstants.lightBlueColor,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  VoiceMassageWidget(
                    model: model,
                    isSender: isMe,
                  ),
                  getSpaceHeight(
                    AppConstants.smallPadding,
                  ),
                  ChatTimeAndSeenWidget(
                    isMe: isMe,
                    isSeen: model.isSeen!,
                    dateOfCreation: model.dateOfCreation!,
                  ),
                ],
              )),

          ///docs filed send
        ]
      ],
    );
  }
}
