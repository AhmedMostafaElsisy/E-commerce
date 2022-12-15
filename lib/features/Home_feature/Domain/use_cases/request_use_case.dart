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
}
