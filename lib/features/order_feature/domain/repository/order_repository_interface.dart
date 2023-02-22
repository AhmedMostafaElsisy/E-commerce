import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';

abstract class OrderRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> getOrderData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> getOrderDetails(
      {required int orderId});

}
