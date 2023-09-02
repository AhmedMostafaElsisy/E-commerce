import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';
import '../../Data/chat_models/chat_user_model.dart';
import '../../Domain/interfaces/chat_archive_interface.dart';
import 'archive_chat_states.dart';

class ArchiveChatsCubit extends Cubit<ArchiveChatsStates> {
  ArchiveChatsCubit(this._repo) : super(FetchArchiveChatsStateInit());

  static ArchiveChatsCubit get(context) => BlocProvider.of(context);

  final ArchiveChatsRepositoryInterface _repo;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<ChatUserModel> chatUserList = [];
  bool hasMoreData = false;

  Future onRefresh() async {
    await getArchivesUser();
  }

  updateView() {
    emit(FetchArchiveChatsStateInit());
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! FetchMoreArchiveChatsLoadingState && hasMoreData) {
        whenScrollChatUserListPagination();
      }
    }
  }

  /// Pagination Function
  whenScrollChatUserListPagination() async {
    page = page + 1;

    try {
      emit(FetchMoreArchiveChatsLoadingState());
      var result = await _repo.getArchiveChats(page: page);
      if (_repo.isError) {
        hasMoreData = false;
        emit(FetchMoreArchiveChatsErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        var tempList = chatUserListFromJson(result.data);
        hasMoreData = tempList.length == 10;
        chatUserList.addAll(tempList);
        emit(FetchMoreArchiveChatsSuccessState());
      }
    } catch (e) {
      hasMoreData = false;
      emit(
        FetchMoreArchiveChatsErrorState(
          error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: e.toString(),
          ),
        ),
      );
    }
  }

  /// Get All ChatUserList List
  getArchivesUser() async {
    emit(FetchArchiveChatsLoadingState());
    try {
      page = 1;
      var result = await _repo.getArchiveChats(page: page);
      if (_repo.isError) {
        emit(FetchArchiveChatsErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        chatUserList = chatUserListFromJson(result.data);
        hasMoreData = chatUserList.length == 10;
        if (chatUserList.isEmpty) {
          emit(FetchArchiveChatsEmptyState());
        } else {
          emit(FetchArchiveChatsSuccessState());
        }
      }
    } catch (e) {
      emit(FetchArchiveChatsErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  deleteOrAddUser(
      {required ChatUserModel chatUserModel,
      required bool isAddToArchive}) async {
    emit(AddOrRemoveArchiveChatLoadingState());
    try {
      BaseModel result;
      if (isAddToArchive) {
        result = await _repo.addArchiveChat(
          chatId: chatUserModel.id,
        );
      } else {
        result = await _repo.removeArchiveChat(
          chatId: chatUserModel.id,
        );
      }

      if (_repo.isError) {
        emit(AddOrRemoveArchiveChatErrorState(
          error: _repo.errorMsg!,
        ));
      } else {
        if (isAddToArchive) {
          chatUserModel.isArchive = true;

          chatUserList.add(chatUserModel);
        } else {
          chatUserModel.isArchive = false;
          chatUserList.remove(chatUserModel);
        }
        emit(AddOrRemoveArchiveChatSuccessState(
          message: result.message!,
          userModel: chatUserModel,
          isAddedToArchive: isAddToArchive,
        ));
      }
    } catch (e) {
      emit(AddOrRemoveArchiveChatErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  removeArchive({required ChatUserModel chatUserModel}) {
    chatUserList.remove(chatUserModel);
    emit(FetchArchiveChatsStateInit());
  }
}
