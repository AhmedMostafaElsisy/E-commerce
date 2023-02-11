import 'package:dartz/dartz.dart';

import '../../../../../core/Error_Handling/custom_error.dart';
import '../../../../../core/model/base_model.dart';

abstract class LocationRepositoryInterface {

  Future<Either<CustomError, BaseModel>> getCityData(
      {int page = 1, int limit = 10});

  Future<Either<CustomError, BaseModel>> getAreaData(
      {int page = 1, int limit = 10, required int cityId});
}
