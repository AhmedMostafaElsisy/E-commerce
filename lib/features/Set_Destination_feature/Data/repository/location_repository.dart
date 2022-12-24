import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:dartz/dartz.dart';

import '../../Domain/repository/location_interface.dart';
import '../data_scources/location_remote_data_scources.dart';

class LocationRepository extends LocationRepositoryInterface {
  final LocationRemoteDataSourceInterface remoteDataSourceInterface;

  LocationRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getLocations({int? page = 1,String? searchKey}) {
    return remoteDataSourceInterface.getLocationData(
      page: page,searchKey: searchKey
    );
  }
}
