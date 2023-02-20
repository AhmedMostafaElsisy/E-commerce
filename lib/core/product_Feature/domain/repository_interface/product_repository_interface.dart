import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:dartz/dartz.dart';

abstract class GeneralProductRepositoryInterface {
  Future<Either<CustomError, List<ProductModel>>> getProductWithOptionParams({
    required int page,
    String? searchName,
    int limit = 10,
    List<CategoryModel>? categories,
    List<TagsModel>? tags,
    String? cityId,
    String? areaId,
  });

  Future<Either<CustomError, ProductModel>> getProductDetails({
    required String productId,
  });
}
