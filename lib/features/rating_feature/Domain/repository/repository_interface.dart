
import 'package:dartz/dartz.dart';

import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class RatingRepositoryInterface extends BaseInterface {

  Future<Either<CustomError, BaseModel>>  addRating({required int driverId,
    required int requestId,
    required int rate,
    required String comment}) ;
}