import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/order_repository_interface.dart';
import '../data_scoures/order_remote_data_scoures.dart';

class OrderRepository extends OrderRepositoryInterface {
  final OrderRemoteDataSourceInterface remoteDataSourceInterface;

  OrderRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getOrderDetails(
      {required int orderId}) {
    return remoteDataSourceInterface.getOrderDetails(orderID: orderId);
  }

  @override
  Future<Either<CustomError, BaseModel>> getOrderData(
      {int page = 1, int? limit}) {
    return remoteDataSourceInterface.getOrderData(limit: limit, page: page);
  }
}
