import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/model/shop_model.dart';
import 'package:captien_omda_customer/features/store_feature/domain/repository/general_stores_repository_interface.dart';
import 'package:dartz/dartz.dart';

class GeneralStoresUesCase {
  final GeneralStoresRepositoryInterface repositoryInterface;

  GeneralStoresUesCase(this.repositoryInterface);

  Future<Either<CustomError, List<ShopModel>>> getGeneralShopList(
      {int page = 1, int? limit}) {
    return repositoryInterface
        .getGeneralStoresData(page: page, limit: limit)
        .then((value) => value.fold((error) => left(error),
            (shopData) => right(shopListFromJson(shopData.data))));
  }

  Future<Either<CustomError, List<ProductModel>>> getGeneralShopProductListList(
      {required int shopId, int page = 1, int? limit}) {
    return repositoryInterface
        .getGeneralStoresProductData(page: page, limit: limit, shopID: shopId)
        .then((value) => value.fold((error) => left(error),
            (products) => right(productListFromJson(products.data))));
  }
}
