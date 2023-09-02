import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class FavoriteStates {}

class FavoriteInitialStates extends FavoriteStates {}

class FavoriteLoadingStates extends FavoriteStates {}

class FavoriteEmptyStates extends FavoriteStates {}

class FavoriteSuccessStates extends FavoriteStates {}

class FavoriteFailedStates extends FavoriteStates {
  CustomError error;

  FavoriteFailedStates(this.error);
}

class FavoriteLoadingMoreDataStates extends FavoriteStates {}

class FavoriteFailedMoreDataStates extends FavoriteStates {
  CustomError error;

  FavoriteFailedMoreDataStates(this.error);
}

class FavoriteFavLoadingStates extends FavoriteStates {
  int productId;

  FavoriteFavLoadingStates(this.productId);
}

class FavoriteAddFavSuccessStates extends FavoriteStates {
  int productId;

  FavoriteAddFavSuccessStates(this.productId);
}

class FavoriteRemoveFavSuccessStates extends FavoriteStates {
  int productId;

  FavoriteRemoveFavSuccessStates(this.productId);
}

class FavoriteFavFailedStates extends FavoriteStates {
  CustomError error;

  FavoriteFavFailedStates(this.error);
}
