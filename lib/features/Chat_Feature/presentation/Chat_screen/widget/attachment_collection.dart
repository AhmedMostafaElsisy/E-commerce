import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../Logic/chat_details_cubit/chat_details_cubit.dart';
import 'attachment_item.dart';

class AttachmentCollection extends StatelessWidget {
  final int receiverId;
  const AttachmentCollection({Key? key, required this.receiverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getWidgetHeight(80),
      right: getWidgetWidth(40),
      left: getWidgetWidth(40),
      child: Container(
        width: getWidgetWidth(320),
        height: getWidgetHeight(170),
        decoration: BoxDecoration(
            color: AppConstants.lightBlueColor,
            borderRadius: BorderRadius.circular(
                AppConstants.containerOfListTitleBorderRadius),
            boxShadow: [
              BoxShadow(
                  color: AppConstants.lightBlackColor.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, -1))
            ]),
        padding: EdgeInsets.symmetric(
            vertical: getWidgetHeight(AppConstants.pagePadding),
            horizontal: getWidgetWidth(32)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .setAttachmentValue(value: false);
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .pickFile(receiverId: receiverId);
                    },
                    child: AttachmentItem(
                      title: AppLocalizations.of(context)!.lblAttachmentDocs,
                      imagePath: "attchment_docs.svg",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .setAttachmentValue(value: false);
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .pickVideoImage(receiverId: receiverId);
                    },
                    child: AttachmentItem(
                      title: AppLocalizations.of(context)!.lblAttachmentVideo,
                      imagePath: "attchment_video.svg",
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .setAttachmentValue(value: false);
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .pickGalleryImage(ImageSource.camera, receiverId);
                    },
                    child: AttachmentItem(
                      title: AppLocalizations.of(context)!.lblCamera,
                      imagePath: "attchment_camera.svg",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .setAttachmentValue(value: false);
                      BlocProvider.of<ChatDetailsCubit>(context)
                          .pickGalleryImage(ImageSource.gallery, receiverId);
                    },
                    child: AttachmentItem(
                      title: AppLocalizations.of(context)!.lblGallery,
                      imagePath: "attchment_gallery.svg",
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     BlocProvider.of<ChatDetailsCubit>(context)
                  //         .setAttachmentValue(value: false);
                  //               },
                  //   child: AttachmentItem(
                  //     title:
                  //         AppLocalizations.of(context)!.lblAttachmentLocation,
                  //     imagePath: "attchment_location.svg",
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     BlocProvider.of<ChatDetailsCubit>(context)
                  //         .setAttachmentValue(value: false);
                  //
                  //     Navigator.of(context).pushNamed(
                  //         RouteNames.myContactsPageRoute,
                  //         arguments: RouteArgument(receiverId: receiverId));
                  //   },
                  //   child: AttachmentItem(
                  //     title: AppLocalizations.of(context)!.lblAttachmentContact,
                  //     imagePath: "contact_attachment.svg",
                  //   ),
                  // ),
                ],
              ),
            ]),
      ),
    );
  }
}
