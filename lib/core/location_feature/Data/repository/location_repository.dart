import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/location_interface.dart';
import '../data_scources/location_remote_data_scources.dart';

class LocationRepository extends LocationRepositoryInterface {
  final LocationRemoteDataSourceInterface remoteDataSourceInterface;

  LocationRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getAreaData(
      {int page = 1, int limit = 10, required int cityId}) {
    return remoteDataSourceInterface.getAreaData(
        cityId: cityId, limit: limit, page: page);
  }

  @override
  Future<Either<CustomError, BaseModel>> getCityData(
      {int page = 1, int limit = 10, }) {
    return remoteDataSourceInterface.getCityData(
         page: page, limit: limit);
  }


}
