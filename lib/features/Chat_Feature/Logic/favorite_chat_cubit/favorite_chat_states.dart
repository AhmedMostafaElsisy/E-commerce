import '../../../../core/Error_Handling/custom_error.dart';
import '../../Data/chat_models/chat_user_model.dart';

abstract class FavoriteChatsStates {}

class FetchFavoriteChatsStateInit extends FavoriteChatsStates {}

///first fetch state
class FetchFavoriteChatsLoadingState extends FavoriteChatsStates {}

class FetchFavoriteChatsEmptyState extends FavoriteChatsStates {}

class FetchFavoriteChatsSuccessState extends FavoriteChatsStates {}

class FetchFavoriteChatsErrorState extends FavoriteChatsStates {
  CustomError? error;

  FetchFavoriteChatsErrorState({
    this.error,
  });
}

///pagination states
class FetchMoreFavoriteChatsLoadingState extends FavoriteChatsStates {}

class FetchMoreFavoriteChatsSuccessState extends FavoriteChatsStates {}

class FetchMoreFavoriteChatsErrorState extends FavoriteChatsStates {
  CustomError? error;

  FetchMoreFavoriteChatsErrorState({
    this.error,
  });
}

///add or remove Conversion to/from Favorite list states

class AddOrRemoveFavoriteChatLoadingState extends FavoriteChatsStates {}

class AddOrRemoveFavoriteChatSuccessState extends FavoriteChatsStates {
  String message;
  ChatUserModel userModel;

  AddOrRemoveFavoriteChatSuccessState({
    required this.message,
    required this.userModel,
  });
}

class AddOrRemoveFavoriteChatErrorState extends FavoriteChatsStates {
  CustomError error;

  AddOrRemoveFavoriteChatErrorState({
    required this.error,
  });
}
