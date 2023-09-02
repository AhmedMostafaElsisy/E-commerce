import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:dartz/dartz.dart';

import '../../Domain/repository/repository_interface.dart';
import '../data_scoures/remote_data_scoures.dart';

class RatingRepository extends RatingRepositoryInterface {
  final RatingRemoteDataSourceInterface remoteDataSourceInterface;

  RatingRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> addRating(
      {required int orderId, required int rate, required String comment}) {
    return remoteDataSourceInterface.addRating(
        orderId: orderId, rate: rate, comment: comment);
  }

  @override
  Future<Either<CustomError, BaseModel>> getStoresRating( {int page = 1, int? limit}) {
    return remoteDataSourceInterface.getStoreRates( limit: limit,page: page);
  }
}
