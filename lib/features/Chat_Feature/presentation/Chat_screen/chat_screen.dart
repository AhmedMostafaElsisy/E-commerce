import 'package:captien_omda_customer/features/Chat_Feature/presentation/Chat_screen/widget/attachment_collection.dart';
import 'package:captien_omda_customer/features/Chat_Feature/presentation/Chat_screen/widget/chat_massage_item.dart';
import 'package:captien_omda_customer/features/Chat_Feature/presentation/Chat_screen/widget/send_massage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../Logic/Recorder_Cubit/recorder_cubit.dart';
import '../../Logic/Websocket_Cubit/websocket_cubit.dart';
import '../../Logic/Websocket_Cubit/websocket_states.dart';
import '../../Logic/chat_details_cubit/chat_details_cubit.dart';
import '../../Logic/chat_details_cubit/chat_details_states.dart';
import '../../Logic/player_Cubit/player_cubit.dart';
import '../massage_chat_screen/chat_loader/massages_loading_lit.dart';

class ChatScreen extends StatefulWidget {
  final RouteArgument argument;

  const ChatScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  late ChatDetailsCubit chatCubit;
  late WebsocketCubit websocketCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SharedText.currentUserOfChat = widget.argument.chatUserModel;
    chatCubit = BlocProvider.of<ChatDetailsCubit>(context);
    websocketCubit = BlocProvider.of<WebsocketCubit>(context);
    BlocProvider.of<ChatDetailsCubit>(context).controller =
        TextEditingController();
    chatCubit.setAttachmentValue(value: false);
    chatCubit.getMassageData(receiverId: widget.argument.chatUserModel!.id);
    chatCubit.scrollController = ScrollController();
    BlocProvider.of<PlayerCubit>(context).initPlayer();
  }

  @override
  void dispose() {
    SharedText.currentUserOfChat = null;
    chatCubit.setAttachmentValue(value: false);
    chatCubit.scrollController.dispose();
    websocketCubit.sendTypingToAnotherUser(
      userToId: widget.argument.chatUserModel!.id.toString(),
      userFromId: SharedText.currentUser!.id.toString(),
      isTyping: false,
    );

    BlocProvider.of<RecorderCubit>(context).resetRecorder();
    BlocProvider.of<ChatDetailsCubit>(context).setVoiceRecord(value: false);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        titleWidget: GestureDetector(
          child: BlocConsumer<WebsocketCubit, WebsocketStates>(
            listener: (webSocketCtx, webSocketState) {
              if (webSocketState is WebSocketUserHaveAnMessageState &&
                  webSocketState.socketModel.isUpdatingWithThisUser(
                      peerUserId:
                          widget.argument.chatUserModel!.id.toString())) {
                chatCubit.getBackOfUserMassageData(
                    receiverId: widget.argument.chatUserModel!.id);
              }
            },
            builder: (webSocketCtx, webSocketState) {
              return SizedBox(
                width: getWidgetWidth(250),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTitleText(
                        textKey: widget.argument.chatUserModel!.name,
                        textFontSize: AppConstants.normalFontSize,
                        textWeight: FontWeight.w700,
                        textColor: AppConstants.lightBlackColor,
                        textAlignment: TextAlign.start,
                      ),
                      if (webSocketState is WebSocketUserTypingState &&
                          webSocketState.socketModel.isTypingWithThisUser(
                              peerUserId: widget.argument.chatUserModel!.id
                                  .toString())) ...[
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!.lblTyping,
                          textFontSize: AppConstants.xxSmallFontSize,
                          textWeight: FontWeight.w400,
                          textColor: AppConstants.lightBlackColor,
                          textAlignment: TextAlign.start,
                        ),
                      ],
                    ]),
              );
            },
          ),
        ),
        withNotification: false,
        showBottomIcon: false,
        withBack: true,
        showLeadingWidget: true,
      ),
      body: BlocConsumer<ChatDetailsCubit, ChatDetailsStates>(
        listener: (chatCtx, chatStates) {
          if (chatStates is MapCubitPermissionDeniedState) {
            showSnackBar(
                context: context,
                title: AppLocalizations.of(context)!.lblLocationDenied,
                color: AppConstants.lightRedColor);
            Navigator.of(context).pop();
          } else if (chatStates is MapCubitPermissionDeniedNeverState) {
            showSnackBar(
                context: context,
                title: chatStates.massage,
                color: AppConstants.lightRedColor);
            Navigator.of(context).pop();
          } else if (chatStates is SendChatMassageFailedStates) {
            checkUserAuth(context: chatCtx, errorType: chatStates.error.type);
            showSnackBar(
                context: context, title: chatStates.error.errorMassage!);
          } else if (chatStates is ChatMassageFailedStates) {
            checkUserAuth(context: chatCtx, errorType: chatStates.error.type);
          } else if (chatStates is SendChatMassageSuccessStates) {
            websocketCubit.sendTypingToAnotherUser(
              userToId: widget.argument.chatUserModel!.id.toString(),
              userFromId: SharedText.currentUser!.id.toString(),
              isTyping: false,
            );
          }
        },
        builder: (chatCtx, chatStates) {
          if (chatStates is ChatMassageLoadingStates) {
            return const MassageLoadingList();
          } else if (chatStates is ChatMassageFailedStates) {
            return CommonError(
              withButton: true,
              errorMassage: chatStates.error.errorMassage,
              onTap: () => chatCubit.getMassageData(
                  receiverId: widget.argument.chatUserModel!.id),
            );
          }
          return InkWell(
            focusColor: AppConstants.transparent,
            highlightColor: AppConstants.transparent,
            hoverColor: AppConstants.transparent,
            splashColor: AppConstants.transparent,
            onTap: () {
              chatCtx.read<ChatDetailsCubit>().setAttachmentValue(value: false);
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          controller: chatCubit.scrollController,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  getWidgetWidth(AppConstants.pagePadding),
                              vertical: getWidgetHeight(
                                  AppConstants.pagePaddingDouble)),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ChatMassageItem(
                                isMe: chatCtx
                                        .read<ChatDetailsCubit>()
                                        .chatMassageModel[index]
                                        .receiverId !=
                                    SharedText.currentUser!.id!,
                                model: chatCtx
                                    .read<ChatDetailsCubit>()
                                    .chatMassageModel[index]);
                          },
                          separatorBuilder: (context, index) {
                            return getSpaceHeight(AppConstants.pagePadding);
                          },
                          itemCount: chatCtx
                              .read<ChatDetailsCubit>()
                              .chatMassageModel
                              .length),
                    ),

                    ///send massage
                    SendMassageWidget(
                      receiverId: widget.argument.chatUserModel!.id,
                      isLoading:
                      chatStates is! SendChatMassageLoadingStates,
                    )
                  ],
                ),
                if (chatCtx.read<ChatDetailsCubit>().showAttachment)

                  ///Attachment
                  AttachmentCollection(
                    receiverId: widget.argument.chatUserModel!.id,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
