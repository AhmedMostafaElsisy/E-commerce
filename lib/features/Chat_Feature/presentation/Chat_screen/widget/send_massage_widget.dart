import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/Helpers/shared_texts.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../Logic/Websocket_Cubit/websocket_cubit.dart';
import '../../../Logic/chat_details_cubit/chat_details_cubit.dart';

class SendMassageWidget extends StatelessWidget {
  final int receiverId;
  final bool isLoading;

  const SendMassageWidget(
      {Key? key, required this.receiverId, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(80),
      padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(AppConstants.pagePadding)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: getWidgetWidth(290),
              height: getWidgetHeight(60),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.smallRadius),
                  color: AppConstants.lightWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        color: AppConstants.lightBlackColor.withOpacity(0.16),
                        offset: const Offset(0, 0),
                        blurRadius: 4)
                  ]),
              padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(10),
                  horizontal: getWidgetWidth(10)),
              child: CommonTextFormField(
                controller:
                    BlocProvider.of<ChatDetailsCubit>(context).controller,
                fieldHeight: getWidgetHeight(60),
                fieldWidth: getWidgetWidth(343),
                onChanged: (str) {
                  BlocProvider.of<ChatDetailsCubit>(context).updateView();
                  if (str != null) {
                    BlocProvider.of<WebsocketCubit>(context)
                        .sendTypingToAnotherUser(
                      userToId: receiverId.toString(),
                      userFromId: SharedText.currentUser!.id.toString(),
                      isTyping: str.isNotEmpty,
                    );
                  }

                  return str;
                },
                withPrefixIcon: false,
                hintKey: AppLocalizations.of(context)!.lblWriteHere,
                keyboardType: TextInputType.text,
                labelHintColor: AppConstants.lightBorderColor,
                labelHintFontSize: 14,

                suffixIcon: InkWell(
                  onTap: () {
                    BlocProvider.of<ChatDetailsCubit>(context)
                        .setAttachmentValue(value: true);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CommonAssetSvgImageWidget(
                      imageString: "add_attachment.svg",
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                withSuffixIcon: true,
                validator: (phone) {
                  return null;
                },
                borderColor: AppConstants.transparent,
                // filledColor: AppConstants.lightBlueColor,
              ),
            ),
            getSpaceWidth(AppConstants.pagePadding),
            if (isLoading) ...[
              // if (BlocProvider.of<ChatDetailsCubit>(context)
              //     .controller
              //     .text
              //     .isEmpty) ...[
              //   GestureDetector(
              //     onTap: () {
              //       debugPrint("test start press ");
              //
              //       hideKeyboard(context);
              //       BlocProvider.of<ChatDetailsCubit>(context)
              //           .setVoiceRecord(value: true);
              //     },
              //     child: const CommonAssetSvgImageWidget(
              //       imageString: "voice_icon.svg",
              //       height: 40,
              //       width: 40,
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ] else ...[
              InkWell(
                onTap: () {
                  hideKeyboard(context);
                  BlocProvider.of<ChatDetailsCubit>(context)
                      .setAttachmentValue(value: false);
                  BlocProvider.of<ChatDetailsCubit>(context)
                      .sendTextMassage(receiverId: receiverId);
                },
                child: RotatedBox(
                  quarterTurns: SharedText.currentLocale == "ar" ? 0 : -2,
                  child: const CommonAssetSvgImageWidget(
                    imageString: "send.svg",
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // ]
            ] else ...[
              const CommonLoadingWidget(),
            ]
          ]),
    );
  }
}
