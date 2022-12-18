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
}
