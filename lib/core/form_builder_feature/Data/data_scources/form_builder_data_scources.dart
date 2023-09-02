import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class FormBuilderRemoteDataSourceInterface {
  ///get product from
  Future<Either<CustomError, BaseModel>> getProductForm(
      {required int categoryId});
}

class FormBuilderRemoteDataSourceImpl
    extends FormBuilderRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getProductForm(
      {required int categoryId}) async {
    try {
      String pathUrl = "${ApiKeys.categoryFormKey}?category_id=$categoryId";
      Response response = await DioHelper.getDate(url: pathUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
