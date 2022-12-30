import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/favorite_repository_interface.dart';
import '../data_scoures/remote_data_scoures.dart';

class FavoriteRepository extends FavoriteRepositoryInterface {
  final FavoriteRemoteDataSourceInterface remoteDataSourceInterface;

  FavoriteRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> addToFavorite(
      {required int productId}) {
    return remoteDataSourceInterface.addToFavorite(productId: productId);
  }

  @override
  Future<Either<CustomError, BaseModel>> getFavoriteData(
      {int page = 1, int? limit}) {
    return remoteDataSourceInterface.getFavoriteData(limit: limit, page: page);
  }

  @override
  Future<Either<CustomError, BaseModel>> removeFromFavorite(
      {required int productId}) {
    return remoteDataSourceInterface.removeFromFavorite(productId: productId);
  }
}
