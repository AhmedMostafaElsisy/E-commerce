import 'package:dartz/dartz.dart';

import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class RequestRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> getRequests({int page = 1, int limit});

  Future<Either<CustomError, BaseModel>> startRequest(
      {required int fromLocationId, required int toLocationId});

  Future<Either<CustomError, BaseModel>> changeRequestStates(
      {required int requestID, required String states});

  Future<Either<CustomError, BaseModel>> getCurrentRequest();
  Future<Either<CustomError, BaseModel>> getRequestDetails({required int requestId});
}
