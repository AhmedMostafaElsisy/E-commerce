import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/model/shop_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/store_repository_interface.dart';

class StoreUesCase {
  final StoreRepositoryInterface repositoryInterface;

  StoreUesCase(this.repositoryInterface);

  Future<Either<CustomError, List<ShopModel>>> getMyShopList(
      {int page = 1, int? limit}) {
    return repositoryInterface.getMyStoreData(page: page, limit: limit).then(
        (value) => value.fold((error) => left(error),
            (shopData) => right(shopListFromJson(shopData.data))));
  }

  Future<Either<CustomError, List<ProductModel>>> getMyShopProductListList(
      {required int shopId, int page = 1, int? limit}) {
    return repositoryInterface
        .getMyStoreProductData(page: page, limit: limit, shopID: shopId)
        .then((value) => value.fold((error) => left(error),
            (products) => right(productListFromJson(products.data))));
  }

  Future<Either<CustomError, BaseModel>> createNewStore({
    required XFile storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required String storeSubCategory,
  }) {
    return repositoryInterface.addNewStore(
        storeImage: storeImage,
        storeName: storeName,
        ownerName: ownerName,
        storeNumber: storeNumber,
        storeEmail: storeEmail,
        storeAddress: storeAddress,
        storeCity: storeCity,
        storeArea: storeArea,
        storeMainCategory: storeMainCategory,
        storeSubCategory: storeSubCategory);
  }

  Future<Either<CustomError, BaseModel>> editStore({
    required int storeId,
    XFile? storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required String storeSubCategory,
  }) {
    return repositoryInterface.editStore(
        storeId: storeId,
        storeImage: storeImage,
        storeName: storeName,
        ownerName: ownerName,
        storeNumber: storeNumber,
        storeEmail: storeEmail,
        storeAddress: storeAddress,
        storeCity: storeCity,
        storeArea: storeArea,
        storeMainCategory: storeMainCategory,
        storeSubCategory: storeSubCategory);
  }
}
