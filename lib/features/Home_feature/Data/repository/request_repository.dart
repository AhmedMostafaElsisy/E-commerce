import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:dartz/dartz.dart';

import '../../Domain/repository/request_interface.dart';
import '../data_scources/request_remote_data_scources.dart';

class RequestRepository extends RequestRepositoryInterface {
  final RequestRemoteDataSourceInterface remoteDataSourceInterface;

  RequestRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getRequests(
      {int page = 1, int? limit}) {
    return remoteDataSourceInterface.getRequestData(page: page, limit: limit);
  }

  @override
  Future<Either<CustomError, BaseModel>> startRequest(
      {required int fromLocationId, required int toLocationId}) {
    return remoteDataSourceInterface.startRequest(
        fromLocationId: fromLocationId, toLocationId: toLocationId);
  }

  @override
  Future<Either<CustomError, BaseModel>> changeRequestStates(
      {required int requestID, required String states}) {
    return remoteDataSourceInterface.changeRequestStates(
        requestID: requestID, states: states);
  }

  @override
  Future<Either<CustomError, BaseModel>> getCurrentRequest() {
    return remoteDataSourceInterface.getCurrentRequest();
  }
}
