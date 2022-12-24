import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_error.dart';
import '../../../Home_feature/Domain/enitiy/request_model.dart';
import '../../../Home_feature/Domain/repository/request_interface.dart';

class TripUesCases {
  final RequestRepositoryInterface repositoryInterface;

  TripUesCases(this.repositoryInterface);

  Future<Either<CustomError, RequestModel>> callStartTrip(
      {required int locationFromId, required int locationToId}) {
    return repositoryInterface
        .startRequest(
            fromLocationId: locationFromId, toLocationId: locationToId)
        .then((value) => value.fold(
            (l) => left(l), (r) => right(RequestModel.fromJson(r.data))));
  }

  Future<Either<CustomError, BaseModel>> callChangeRequestStates(
      {required int requestID, required String states}) {
    return repositoryInterface.changeRequestStates(
        requestID: requestID, states: states);
  }

  Future<Either<CustomError, RequestModel>> callCurrentRequest() {
    return repositoryInterface.getCurrentRequest().then((value) => value.fold(
        (l) => left(l), (r) => right(RequestModel.fromJson(r.data))));
  }
}
