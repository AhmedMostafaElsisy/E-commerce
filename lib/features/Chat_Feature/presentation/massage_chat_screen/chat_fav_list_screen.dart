// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../Constants/Enums/chat_card_types.dart';
// import '../../../Constants/app_constants.dart';
// import '../../../Helpers/shared.dart';
// import '../../../Logic/Bloc_Cubits/chat/favorite_chat_cubit/favorite_chat_cubit.dart';
// import '../../../Logic/Bloc_Cubits/chat/favorite_chat_cubit/favorite_chat_states.dart';
// import '../../Widgets/Loader_Widgets/chat_loader/conversation_loading_list.dart';
// import '../../Routes/route_argument_model.dart';
// import '../../Routes/route_names.dart';
// import '../../Widgets/common_empty_widget.dart';
// import '../../Widgets/common_error_widget.dart';
// import '../../Widgets/custom_snack_bar.dart';
// import 'widget/press_and_hold_function.dart';
// import 'widget/user_info_massage_item.dart';
//
// class ChatFavListScreen extends StatefulWidget {
//   const ChatFavListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatFavListScreen> createState() => _ChatFavListScreenState();
// }
//
// class _ChatFavListScreenState extends State<ChatFavListScreen> {
//   late FavoriteChatsCubit favoriteChatsCubit;
//
//   @override
//   void initState() {
//     super.initState();
//     favoriteChatsCubit = BlocProvider.of<FavoriteChatsCubit>(context);
//     favoriteChatsCubit.getFavoritesUser();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: getWidgetHeight(AppConstants.pagePadding)),
//       child: BlocConsumer<FavoriteChatsCubit, FavoriteChatsStates>(
//         listener: (chatListCtx, chatListState) {
//           if (chatListState is FetchFavoriteChatsErrorState) {
//             checkUserAuth(
//                 context: context, errorType: chatListState.error!.type);
//           } else if (chatListState is AddOrRemoveFavoriteChatErrorState) {
//             checkUserAuth(
//                 context: context, errorType: chatListState.error.type);
//           } else if (chatListState is AddOrRemoveFavoriteChatSuccessState) {
//             showSnackBar(
//               context: context,
//               title: chatListState.message,
//               color: AppConstants.mainColor,
//             );
//           }
//         },
//         builder: (chatListCtx, chatListState) {
//           if (chatListState is FetchFavoriteChatsLoadingState ||
//               chatListState is AddOrRemoveFavoriteChatLoadingState) {
//             return const ConversationLoaderWidget();
//           } else if (chatListState is FetchFavoriteChatsErrorState) {
//             return CommonError(
//               errorMassage: chatListState.error!.errorMassage,
//               onTap: () {
//                 favoriteChatsCubit.getFavoritesUser();
//               },
//             );
//           } else if (chatListState is FetchFavoriteChatsEmptyState) {
//             return EmptyScreen(
//               imageString: "empty_search.svg",
//               imageWidth: 250,
//               imageHeight: 200,
//               titleKey: AppLocalizations.of(context)!.lblNoResultFount,
//               description: AppLocalizations.of(context)!.lblAddUserToFavFirst,
//               withButton: false,
//             );
//           } else {
//             return ListView.separated(
//                 physics: const BouncingScrollPhysics(),
//                 padding: EdgeInsets.only(bottom: getWidgetHeight(400)),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.of(context).pushNamed(RouteNames.chatPageRoute,
//                           arguments: RouteArgument(
//                               chatUserModel:
//                                   favoriteChatsCubit.chatUserList[index]));
//                     },
//                     onLongPress: () {
//                       pressAndHoldBottomSheet(
//                           context: context,
//                           height: 120,
//                           withDelete: false,
//                           showArchive: false,
//                           isFavorite: true,
//                           favoriteClicked: () {
//                             Navigator.pop(context);
//                             favoriteChatsCubit.deleteOrAddUser(
//                                 chatUserModel:
//                                     favoriteChatsCubit.chatUserList[index]);
//                           });
//                     },
//                     child: UserInfoMassageItem(
//                       isOnline: Random().nextBool(),
//                       cardType: ChatCardType.chatting,
//                       model: favoriteChatsCubit.chatUserList[index],
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return getSpaceHeight(AppConstants.pagePadding);
//                 },
//                 itemCount: favoriteChatsCubit.chatUserList.length);
//           }
//         },
//       ),
//     );
//   }
// }
