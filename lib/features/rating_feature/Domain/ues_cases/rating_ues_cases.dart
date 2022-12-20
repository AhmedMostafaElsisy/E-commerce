import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_error.dart';
import '../repository/repository_interface.dart';

class RatingUesCases {
  final RatingRepositoryInterface repositoryInterface;

  RatingUesCases(this.repositoryInterface);

  Future<Either<CustomError, BaseModel>> callAddRating(
      {required int driverId,
      required int requestId,
      required int rate,
      required String comment}) {
    return repositoryInterface.addRating(
        driverId: driverId, requestId: requestId, rate: rate, comment: comment);
  }
}
