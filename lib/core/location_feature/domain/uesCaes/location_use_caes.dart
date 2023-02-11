import 'package:dartz/dartz.dart';
import '../../../../../core/Error_Handling/custom_error.dart';
import '../model/location_area_model.dart';
import '../repository/location_interface.dart';

class LocationUesCases {
  final LocationRepositoryInterface repositoryInterface;

  LocationUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<LocationAreaModel>>> callCityList(
      {int page = 1, int limit = 10, }) {
    return repositoryInterface
        .getCityData(page: page, limit: limit,)
        .then((value) => value.fold(
            (l) => Left(l), (r) => right(locationAreaListFromJson(r.data))));
  }

  Future<Either<CustomError, List<LocationAreaModel>>> callAreaList(
      {int page = 1, int limit = 10, required int cityId}) {
    return repositoryInterface
        .getAreaData(page: page, limit: limit, cityId: cityId)
        .then((value) => value.fold(
            (l) => Left(l), (r) => right(locationAreaListFromJson(r.data))));
  }
}
