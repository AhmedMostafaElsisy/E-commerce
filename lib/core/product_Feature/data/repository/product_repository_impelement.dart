import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repository_interface/product_repository_interface.dart';
import '../data_sources/product_remote_data_scources.dart';

class GeneralProductRepositoryImpl extends GeneralProductRepositoryInterface {
  GeneralProductsDataSourceInterface dataSource;

  GeneralProductRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<CustomError, List<ProductModel>>> getProductWithOptionParams({
    required int page,
    String? searchName,
    int limit = 10,
    List<CategoryModel>? categories,
    List<TagsModel>? tags,
    String? cityId,
    String? areaId,
  }) {
    return dataSource
        .getProductWithOption(
          page: page,
          limit: limit,
          categories: categories,
          tags: tags,
          cityId: cityId,
          areaId: areaId,
        )
        .then((value) => value.fold(
              (l) => Left(l),
              (response) {
                debugPrint("respone is ${response.data}");
                List<ProductModel> products =
                    productListFromJson(response.data);
                return Right(products);
              },
            ));
  }

  @override
  Future<Either<CustomError, ProductModel>> getProductDetails(
      {required String productId}) {
    return dataSource
        .getProductDetails(
          productId: productId,
        )
        .then((value) => value.fold(
              (l) => Left(l),
              (response) {
                debugPrint("response of product details is ${response.data}");
                ProductModel product = ProductModel.fromJson(response.data);
                return Right(product);
              },
            ));
  }
}
