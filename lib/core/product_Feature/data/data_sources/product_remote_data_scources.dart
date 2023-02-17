import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/Constants/Keys/api_keys.dart';
import '../../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../../core/Error_Handling/custom_error.dart';
import '../../../../../core/Error_Handling/custom_exception.dart';
import '../../../../../core/model/base_model.dart';

abstract class GeneralProductsDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getProductWithOption({
    int page = 1,
    int limit = 10,
    List<CategoryModel>? categories,
    List<TagsModel>? tags,
    String? cityId,
    String? areaId,
  });
}

class GeneralProductRemoteDataSourceImpl
    extends GeneralProductsDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getProductWithOption({
    int page = 1,
    int limit = 10,
    List<CategoryModel>? categories,
    List<TagsModel>? tags,
    String? cityId,
    String? areaId,
  }) async {
    try {
      String pathUrl = "${ApiKeys.generalProduct}?limit=$limit&page=$page";

      if (categories != null) {
        for (int i = 0; i < categories.length; i++) {
          pathUrl += "categories_id[$i]=${categories[i]}";
        }
      }
      if (tags != null) {
        for (int i = 0; i < tags.length; i++) {
          pathUrl += "tags_id[$i]=${tags[i]}";
        }
      }
      if (cityId != null) {
        pathUrl += "city_id=$cityId";
      }
      if (areaId != null) {
        pathUrl += "areaId=$areaId";
      }

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
