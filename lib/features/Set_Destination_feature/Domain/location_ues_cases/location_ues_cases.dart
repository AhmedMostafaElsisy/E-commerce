import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../repository/location_interface.dart';

class LocationUesCases {
  final LocationRepositoryInterface repositoryInterface;

  LocationUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<LocationModel>>> callLocationList({String? searchKey,int?page}) {
    return repositoryInterface.getLocations(searchKey: searchKey,page: page).then((value) =>
        value.fold((l) => Left(l), (r) => right(locationListFromJson(r.data))));
  }
}
