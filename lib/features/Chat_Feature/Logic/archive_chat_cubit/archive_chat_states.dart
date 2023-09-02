import '../../../../core/Error_Handling/custom_error.dart';
import '../../Data/chat_models/chat_user_model.dart';

abstract class ArchiveChatsStates {}

class FetchArchiveChatsStateInit extends ArchiveChatsStates {}

///first fetch state
class FetchArchiveChatsLoadingState extends ArchiveChatsStates {}

class FetchArchiveChatsEmptyState extends ArchiveChatsStates {}

class FetchArchiveChatsSuccessState extends ArchiveChatsStates {}

class FetchArchiveChatsErrorState extends ArchiveChatsStates {
  CustomError? error;

  FetchArchiveChatsErrorState({
    this.error,
  });
}

///pagination states
class FetchMoreArchiveChatsLoadingState extends ArchiveChatsStates {}

class FetchMoreArchiveChatsSuccessState extends ArchiveChatsStates {}

class FetchMoreArchiveChatsErrorState extends ArchiveChatsStates {
  CustomError? error;

  FetchMoreArchiveChatsErrorState({
    this.error,
  });
}

///add or remove Conversion to/from Archive list states

class AddOrRemoveArchiveChatLoadingState extends ArchiveChatsStates {}

class AddOrRemoveArchiveChatSuccessState extends ArchiveChatsStates {
  String message;
  ChatUserModel userModel;
  bool isAddedToArchive;

  AddOrRemoveArchiveChatSuccessState({
    required this.message,
    required this.userModel,
    required this.isAddedToArchive,
  });
}

class AddOrRemoveArchiveChatErrorState extends ArchiveChatsStates {
  CustomError error;

  AddOrRemoveArchiveChatErrorState({
    required this.error,
  });
}
