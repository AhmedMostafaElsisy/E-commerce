import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import '../model/order_model.dart';
import '../repository/order_repository_interface.dart';

class OrderUesCase {
  final OrderRepositoryInterface orderRepositoryInterface;

  OrderUesCase(this.orderRepositoryInterface);

  Future<Either<CustomError, List<OrderModel>>> getOrderData(
      {int page = 1, int? limit}) {
    return orderRepositoryInterface
        .getOrderData(page: page, limit: limit)
        .then((value) => value.fold((error) => left(error),
            (data) => right(orderListFromJson(data.data))));
  }

  Future<Either<CustomError, BaseModel>> getOrderDetails(
      {required int orderId}) {
    return orderRepositoryInterface.getOrderDetails(orderId: orderId);
  }
}
