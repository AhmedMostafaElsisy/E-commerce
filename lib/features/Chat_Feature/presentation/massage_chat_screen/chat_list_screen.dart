import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/Enums/chat/chat_card_types.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../Logic/Chat_Cubit/chat_cubit.dart';
import '../../Logic/Chat_Cubit/chat_states.dart';
import '../../Logic/archive_chat_cubit/archive_chat_cubit.dart';
import '../../Logic/archive_chat_cubit/archive_chat_states.dart';
import '../../Logic/favorite_chat_cubit/favorite_chat_cubit.dart';
import '../../Logic/favorite_chat_cubit/favorite_chat_states.dart';
import 'chat_loader/conversation_loading_list.dart';
import 'widget/press_and_hold_function.dart';
import 'widget/user_info_massage_item.dart';

///screen to fetch user data
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ChatUsersCubit chatUsersCubit;
  late FavoriteChatsCubit favoriteChatsCubit;
  late ArchiveChatsCubit archiveChatsCubit;

  @override
  void initState() {
    super.initState();
    chatUsersCubit = BlocProvider.of<ChatUsersCubit>(context);
    favoriteChatsCubit = BlocProvider.of<FavoriteChatsCubit>(context);
    archiveChatsCubit = BlocProvider.of<ArchiveChatsCubit>(context);
    chatUsersCubit.getUsersOfChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MainAppPage(
        screenContent: Column(
          children: [
            CommonAppBar(
              withBack: true,
              appBarBackGroundColor: AppConstants.transparent,
              showBottomIcon: false,
              centerTitle: false,
              titleWidget: CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblMassages,
                textColor: AppConstants.lightBlackColor,
                textWeight: FontWeight.w400,
                textFontSize: AppConstants.normalFontSize,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidgetHeight(AppConstants.pagePadding)),
              child: BlocListener<ArchiveChatsCubit, ArchiveChatsStates>(
                listener: (archiveListCtx, archiveListState) {
                  if (archiveListState is AddOrRemoveArchiveChatErrorState) {
                    checkUserAuth(
                        context: context,
                        errorType: archiveListState.error.type);
                    showSnackBar(
                        context: context,
                        title: archiveListState.error.errorMassage!);
                  } else if (archiveListState
                      is AddOrRemoveArchiveChatSuccessState) {
                    if (archiveListState.isAddedToArchive) {
                      chatUsersCubit.updateUserArchivedState(
                          chatUserModel: archiveListState.userModel,
                          isAddedToArchive: archiveListState.isAddedToArchive);
                    } else {
                      chatUsersCubit.updateUserArchivedState(
                          chatUserModel: archiveListState.userModel,
                          isAddedToArchive: archiveListState.isAddedToArchive);
                    }
                    showSnackBar(
                      context: context,
                      title: archiveListState.message,
                      color: AppConstants.mainColor,
                    );
                  }
                },
                child: BlocListener<FavoriteChatsCubit, FavoriteChatsStates>(
                  listener: (chatListCtx, chatListState) {
                    if (chatListState is AddOrRemoveFavoriteChatErrorState) {
                      checkUserAuth(
                          context: context,
                          errorType: chatListState.error.type);
                      showSnackBar(
                          context: context,
                          title: chatListState.error.errorMassage!);
                    } else if (chatListState
                        is AddOrRemoveFavoriteChatSuccessState) {
                      showSnackBar(
                        context: context,
                        title: chatListState.message,
                        color: AppConstants.mainColor,
                      );
                    }
                  },
                  child: BlocConsumer<ChatUsersCubit, ChatUsersStates>(
                    listener: (chatListCtx, chatListState) {
                      if (chatListState is DeleteChatConversionErrorState) {
                        checkUserAuth(
                            context: context,
                            errorType: chatListState.error.type);
                      } else if (chatListState is FetchChatUsersErrorState) {
                        checkUserAuth(
                            context: context,
                            errorType: chatListState.error!.type);
                      }
                    },
                    builder: (chatListCtx, chatListState) {
                      if (chatListState is FetchChatUsersLoadingState ||
                          chatListState is DeleteChatConversionLoadingState) {
                        return const ConversationLoaderWidget();
                      } else if (chatListState is FetchChatUsersErrorState) {
                        return CommonError(
                          errorMassage: chatListState.error!.errorMassage,
                          onTap: () {
                            chatUsersCubit.getUsersOfChat();
                          },
                        );
                      } else if (chatListState is FetchChatUsersEmptyState) {
                        return EmptyScreen(
                          imageString: "empty_search.svg",
                          imageWidth: 250,
                          imageHeight: 200,
                          titleKey:
                              AppLocalizations.of(context)!.lblNoResultFount,
                          description: AppLocalizations.of(context)!
                              .lblStartChatWithUserFirst,
                          withButton: false,
                        );
                      } else {
                        return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  EdgeInsets.only(bottom: getWidgetHeight(50)),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteNames.chatPageRoute,
                                        arguments: RouteArgument(
                                            chatUserModel: chatUsersCubit
                                                .chatUserList[index]));
                                  },
                                  onLongPress: () {
                                    pressAndHoldBottomSheet(
                                      context: context,
                                      deleteChatClicked: () {
                                        Navigator.pop(context);
                                        chatUsersCubit.deleteConversion(
                                            chatUserModel: chatUsersCubit
                                                .chatUserList[index]);
                                      },
                                    );
                                  },
                                  child: UserInfoMassageItem(
                                    isOnline: chatUsersCubit
                                        .chatUserList[index].isOnline!,
                                    cardType: ChatCardType.chatting,
                                    model: chatUsersCubit.chatUserList[index],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return getSpaceHeight(AppConstants.pagePadding);
                              },
                              itemCount: chatUsersCubit.chatUserList.length),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
