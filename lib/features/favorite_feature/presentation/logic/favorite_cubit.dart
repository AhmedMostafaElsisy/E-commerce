import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/product_model.dart';
import '../../domain/ues_cases/ues_cases.dart';
import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(this.uesCase) : super(FavoriteInitialStates());

  static FavoriteCubit get(context) => BlocProvider.of(context);
  final FavoriteUesCase uesCase;

  List<ProductModel> productList = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getFavoriteListData() async {
    emit(FavoriteLoadingStates());
    page = 1;
    var result = await uesCase.getFavoriteList(page: page);
    result.fold((error) => emit(FavoriteFailedStates(error)), (data) {
      productList = data;
      if (productList.isEmpty) {
        emit(FavoriteEmptyStates());
      } else {
        emit(FavoriteSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! FavoriteLoadingMoreDataStates && hasMoreData) {
        whenScrollFavoritePagination();
      }
    }
  }

  ///get request history pagination
  whenScrollFavoritePagination() async {
    emit(FavoriteLoadingMoreDataStates());
    page = page + 1;
    var result = await uesCase.getFavoriteList(page: page);

    result.fold(
      (error) => emit(FavoriteFailedMoreDataStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        productList.addAll(data);
        emit(FavoriteSuccessStates());
      },
    );
  }

  addItemToFav({required int productId}) async {
    emit(FavoriteFavLoadingStates(productId));
    var result = await uesCase.addProductToFavorite(productId: productId);
    result.fold((error) => emit(FavoriteFavFailedStates(error)),
        (success) => emit(FavoriteAddFavSuccessStates(productId)));
  }

  removeItemFromFav({required int productId}) async {
    emit(FavoriteFavLoadingStates(productId));
    var result = await uesCase.removeProductFromFavorite(productId: productId);
    result.fold((error) => emit(FavoriteFavFailedStates(error)),
        (success) => emit(FavoriteRemoveFavSuccessStates(productId)));
  }

  removeItemFromFavLocal({required int productId}) {
    productList.removeWhere((element) => element.id == productId);
    emit(FavoriteInitialStates());
  }
}
