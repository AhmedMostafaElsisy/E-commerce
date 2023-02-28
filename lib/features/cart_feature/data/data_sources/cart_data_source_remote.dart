import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class CartDataSourceRemoteInterface {
  Future<Either<CustomException, BaseModel>> getCartItems();

  Future<Either<CustomException, BaseModel>> addOREditProductQuantityCart({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, BaseModel>> removeProduct({
    required int productId,
  });

  Future<Either<CustomException, BaseModel>> checkOut();
}

class CartDataSourceRemoteImplement implements CartDataSourceRemoteInterface {
  @override
  Future<Either<CustomException, BaseModel>> addOREditProductQuantityCart(
      {required int productId, required int quantity}) async {
    try {
      FormData staticData = FormData();
      String pathUrl = ApiKeys.editProductQuantity;
      staticData.fields.add(MapEntry("product_id", productId.toString()));
      staticData.fields.add(MapEntry("count", quantity.toString()));
      Response response = await DioHelper.postData(
        url: pathUrl,
        data: staticData,
      );
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomException(
          error: CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      )));
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> getCartItems() async {
    try {
      String pathUrl = ApiKeys.getCartList;

      Response response = await DioHelper.getDate(
        url: pathUrl,
      );
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomException(
          error: CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      )));
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> removeProduct(
      {required int productId}) async {
    try {
      FormData staticData = FormData();
      String pathUrl = ApiKeys.removeFavoriteKey;
      staticData.fields.add(MapEntry("product_id", productId.toString()));

      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomException(
          error: CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      )));
    }
  }

  @override
  Future<Either<CustomException, BaseModel>> checkOut() async {
    try {
      String pathUrl = ApiKeys.createOrder;

      Response response =
          await DioHelper.postData(url: pathUrl, data: FormData());
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomException(
          error: CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      )));
    }
  }
}
