import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../Data/chat_models/chat_user_model.dart';
import '../../Domain/interfaces/chat_list_interface.dart';
import 'chat_states.dart';

class ChatUsersCubit extends Cubit<ChatUsersStates> {
  ChatUsersCubit(this._repo) : super(FetchChatUsersStateInit());

  static ChatUsersCubit get(context) => BlocProvider.of(context);

  final ChatListRepositoryInterface _repo;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<ChatUserModel> chatUserList = [];
  bool hasMoreData = false;

  Future onRefresh() async {
    await getUsersOfChat();
  }

  updateView() {
    emit(FetchChatUsersStateInit());
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! FetchMoreChatUsersLoadingState && hasMoreData) {
        whenScrollChatUserListPagination();
      }
    }
  }

  /// Pagination Function
  whenScrollChatUserListPagination() async {
    page = page + 1;

    try {
      emit(FetchMoreChatUsersLoadingState());
      var result = await _repo.getChatList(page: page);
      if (_repo.isError) {
        hasMoreData = false;
        emit(FetchMoreChatUsersErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        var tempList = chatUserListFromJson(result.data);
        hasMoreData = tempList.length == 10;
        chatUserList.addAll(tempList);
        emit(FetchMoreChatUsersSuccessState());
      }
    } catch (e) {
      hasMoreData = false;
      emit(
        FetchMoreChatUsersErrorState(
          error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: e.toString(),
          ),
        ),
      );
    }
  }

  /// Get All ChatUserList List
  getUsersOfChat() async {
    emit(FetchChatUsersLoadingState());
    try {
      page = 1;

      var result = await _repo.getChatList(page: page);
      if (_repo.isError) {
        emit(FetchChatUsersErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        chatUserList = chatUserListFromJson(result.data);
        hasMoreData = chatUserList.length == 10;
        if (chatUserList.isEmpty) {
          emit(FetchChatUsersEmptyState());
        } else {
          emit(FetchChatUsersSuccessState());
        }
      }
    } catch (e) {
      emit(FetchChatUsersErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  deleteConversion({required ChatUserModel chatUserModel}) async {
    emit(DeleteChatConversionLoadingState());
    try {
      await _repo.deleteChat(
        chatId: chatUserModel.id,
      );
      if (_repo.isError) {
        emit(DeleteChatConversionErrorState(
          error: _repo.errorMsg!,
        ));
      } else {
        chatUserList.remove(chatUserModel);
        emit(DeleteChatConversionSuccessState(chatUserModel));
      }
    } catch (e) {
      emit(FetchChatUsersErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  updateUserFavoriteState({required ChatUserModel chatUserModel}) {
    chatUserList.map((element) {
      if (element.id == chatUserModel.id) {
        element.isFavorite = chatUserModel.isFavorite;
      }
    });
    emit(FetchChatUsersSuccessState());
  }

  updateUserArchivedState(
      {required ChatUserModel chatUserModel, required bool isAddedToArchive}) {
    if (isAddedToArchive) {
      chatUserList.removeWhere((value) {
        return value.id == chatUserModel.id;
      });
      emit(FetchChatUsersSuccessState());
    } else {
      getUsersOfChat();
    }
  }
}
