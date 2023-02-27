import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/general_product_feature/domain/repository_interface/product_repository_interface.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:dartz/dartz.dart';

class GeneralProductUseCase {
  GeneralProductRepositoryInterface repository;

  GeneralProductUseCase({required this.repository});

  Future<Either<CustomError, List<ProductModel>>> getHomePageProductUseCase() {
    return repository.getProductWithOptionParams(
      page: 1,
    );
  }

  Future<Either<CustomError, List<ProductModel>>> getProductWithFilterUseCase({
    required int page,
    String? searchName,
    List<CategoryModel>? categories,
    List<TagsModel>? tags,
    String? cityId,
    String? areaId,
  }) {
    return repository.getProductWithOptionParams(
        page: page,
        searchName: searchName,
        categories: categories,
        tags: tags,
        areaId: areaId,
        cityId: cityId);
  }

  Future<Either<CustomError, ProductModel>> getProductDetailsUseCase({
    required String productId,
  }) {
    return repository.getProductDetails(
      productId: productId,
    );
  }
}
