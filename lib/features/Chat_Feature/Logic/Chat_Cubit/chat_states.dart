import '../../../../core/Error_Handling/custom_error.dart';
import '../../Data/chat_models/chat_user_model.dart';

abstract class ChatUsersStates {}

class FetchChatUsersStateInit extends ChatUsersStates {}

///first fetch state
class FetchChatUsersLoadingState extends ChatUsersStates {}

class FetchChatUsersEmptyState extends ChatUsersStates {}

class FetchChatUsersSuccessState extends ChatUsersStates {}

class FetchChatUsersErrorState extends ChatUsersStates {
  CustomError? error;

  FetchChatUsersErrorState({
    this.error,
  });
}

///pagination states
class FetchMoreChatUsersLoadingState extends ChatUsersStates {}

class FetchMoreChatUsersSuccessState extends ChatUsersStates {}

class FetchMoreChatUsersErrorState extends ChatUsersStates {
  CustomError? error;

  FetchMoreChatUsersErrorState({
    this.error,
  });
}

///delete Conversion states
class DeleteChatConversionLoadingState extends ChatUsersStates {}

class DeleteChatConversionSuccessState extends ChatUsersStates {
  ChatUserModel chatModel;

  DeleteChatConversionSuccessState(this.chatModel);
}

class DeleteChatConversionErrorState extends ChatUsersStates {
  CustomError error;

  DeleteChatConversionErrorState({
    required this.error,
  });
}
