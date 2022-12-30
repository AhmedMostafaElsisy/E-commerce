import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';

abstract class FavoriteRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> getFavoriteData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> addToFavorite(
      {required int productId});

  Future<Either<CustomError, BaseModel>> removeFromFavorite(
      {required int productId});
}
