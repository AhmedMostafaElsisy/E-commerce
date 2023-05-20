import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../Data/chat_models/chat_user_model.dart';
import '../../Domain/interfaces/favorite_chat_interface.dart';
import 'favorite_chat_states.dart';

class FavoriteChatsCubit extends Cubit<FavoriteChatsStates> {
  FavoriteChatsCubit(this._repo) : super(FetchFavoriteChatsStateInit());

  static FavoriteChatsCubit get(context) => BlocProvider.of(context);

  final FavoriteChatsRepositoryInterface _repo;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<ChatUserModel> chatUserList = [];
  bool hasMoreData = false;

  Future onRefresh() async {
    await getFavoritesUser();
  }

  updateView() {
    emit(FetchFavoriteChatsStateInit());
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! FetchMoreFavoriteChatsLoadingState && hasMoreData) {
        whenScrollChatUserListPagination();
      }
    }
  }

  /// Pagination Function
  whenScrollChatUserListPagination() async {
    page = page + 1;

    try {
      emit(FetchMoreFavoriteChatsLoadingState());
      var result = await _repo.getFavoriteChats(page: page);
      if (_repo.isError) {
        hasMoreData = false;
        emit(FetchMoreFavoriteChatsErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        var tempList = chatUserListFromJson(result.data);
        hasMoreData = tempList.length == 10;
        chatUserList.addAll(tempList);
        emit(FetchMoreFavoriteChatsSuccessState());
      }
    } catch (e) {
      hasMoreData = false;
      emit(
        FetchMoreFavoriteChatsErrorState(
          error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: e.toString(),
          ),
        ),
      );
    }
  }

  /// Get All ChatUserList List
  getFavoritesUser() async {
    emit(FetchFavoriteChatsLoadingState());
    try {
      page = 1;
      var result = await _repo.getFavoriteChats(page: page);
      if (_repo.isError) {
        emit(FetchFavoriteChatsErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        chatUserList = chatUserListFromJson(result.data);
        hasMoreData = chatUserList.length == 10;
        if (chatUserList.isEmpty) {
          emit(FetchFavoriteChatsEmptyState());
        } else {
          emit(FetchFavoriteChatsSuccessState());
        }
      }
    } catch (e) {
      emit(FetchFavoriteChatsErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  deleteOrAddUser({required ChatUserModel chatUserModel}) async {
    emit(AddOrRemoveFavoriteChatLoadingState());
    try {
      var result = await _repo.addOrRemoveFavoriteChat(
        chatId: chatUserModel.id,
      );
      if (_repo.isError) {
        emit(AddOrRemoveFavoriteChatErrorState(
          error: _repo.errorMsg!,
        ));
      } else {
        if (result.code == 0) {
          chatUserModel.isFavorite = false;
          chatUserList.remove(chatUserModel);
        } else {
          chatUserModel.isFavorite = true;

          chatUserList.add(chatUserModel);
        }
        emit(AddOrRemoveFavoriteChatSuccessState(
          message: result.message!,
          userModel: chatUserModel,
        ));
      }
    } catch (e) {
      emit(AddOrRemoveFavoriteChatErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }
}
