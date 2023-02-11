import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class GeneralStoresRepositoryInterface {
  Future<Either<CustomError, BaseModel>> getGeneralStoresData(
      {int page = 1, int? limit});
  Future<Either<CustomError, BaseModel>> getGeneralStoresProductData(
      {required int shopID, int page = 1, int? limit});
}
