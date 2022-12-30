import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:dartz/dartz.dart';

import '../repository/favorite_repository_interface.dart';

class FavoriteUesCase {
  final FavoriteRepositoryInterface favoriteRepositoryInterface;

  FavoriteUesCase(this.favoriteRepositoryInterface);

  Future<Either<CustomError, List<ProductModel>>> getFavoriteList(
      {int page = 1, int? limit}) {
    return favoriteRepositoryInterface
        .getFavoriteData(page: page, limit: limit)
        .then((value) => value.fold((error) => left(error),
            (favoriteData) => right(productListFromJson(favoriteData.data))));
  }

  Future<Either<CustomError, BaseModel>> addProductToFavorite(
      {required int productId}) {
    return favoriteRepositoryInterface.addToFavorite(productId: productId);
  }

  Future<Either<CustomError, BaseModel>> removeProductFromFavorite(
      {required int productId}) {
    return favoriteRepositoryInterface.removeFromFavorite(productId: productId);
  }
}
