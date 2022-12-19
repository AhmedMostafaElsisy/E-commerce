import 'package:dartz/dartz.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../enitiy/request_model.dart';
import '../repository/request_interface.dart';

class RequestUesCases {
  final RequestRepositoryInterface repositoryInterface;

  RequestUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<RequestModel>>> callHomeRequest() {
    return repositoryInterface
        .getRequests(
          limit: 4,
        )
        .then((value) => value.fold(
            (l) => Left(l), (r) => right(requestListFromJson(r.data))));
  }

  Future<Either<CustomError, List<RequestModel>>> callHistoryRequest(
      {int page = 1}) {
    return repositoryInterface.getRequests(page: page).then((value) =>
        value.fold((l) => Left(l), (r) => right(requestListFromJson(r.data))));
  }

  Future<Either<CustomError, RequestModel>> callRequestDetails(
      {required int requestId}) {
    return repositoryInterface.getRequestDetails(requestId: requestId).then(
        (value) => value.fold(
            (l) => Left(l), (r) => right(RequestModel.fromJson(r.data))));
  }
}
