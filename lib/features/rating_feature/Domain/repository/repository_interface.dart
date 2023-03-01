import 'package:dartz/dartz.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class RatingRepositoryInterface {
  Future<Either<CustomError, BaseModel>> addRating(
      {
      required int orderId,
      required int rate,
      required String comment});
}
