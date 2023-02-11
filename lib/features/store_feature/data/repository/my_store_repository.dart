import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/tags_feature/domain/model/tags_model.dart';
import '../../domain/repository/store_repository_interface.dart';
import '../data_scoures/remote_data_scoures.dart';

class StoreRepository extends StoreRepositoryInterface {
  final StoreRemoteDataSourceInterface remoteDataSourceInterface;

  StoreRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> addNewStore(
      {required XFile storeImage,
      required String storeName,
      required String ownerName,
      required String storeNumber,
      required String storeEmail,
      required String storeAddress,
      required String storeCity,
      required String storeArea,
      required String storeMainCategory,
      required List<TagsModel> storeSubCategory}) {
    return remoteDataSourceInterface.createStore(
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

  @override
  Future<Either<CustomError, BaseModel>> editStore(
      {required int storeId,
      XFile? storeImage,
      required String storeName,
      required String ownerName,
      required String storeNumber,
      required String storeEmail,
      required String storeAddress,
      required String storeCity,
      required String storeArea,
      required String storeMainCategory,
      required String storeSubCategory}) {
    return remoteDataSourceInterface.editStore(
        storeId: storeId,
        storeName: storeName,
        ownerName: ownerName,
        storeNumber: storeNumber,
        storeEmail: storeEmail,
        storeAddress: storeAddress,
        storeCity: storeCity,
        storeArea: storeArea,
        storeMainCategory: storeMainCategory,
        storeSubCategory: storeSubCategory,
        storeImage: storeImage);
  }

  @override
  Future<Either<CustomError, BaseModel>> getMyStoreData(
      {int page = 1, int? limit}) {
    return remoteDataSourceInterface.getStoreData(page: page, limit: limit);
  }

  @override
  Future<Either<CustomError, BaseModel>> getMyStoreProductData({required int shopID, int page = 1, int? limit}) {
    return remoteDataSourceInterface.getStoreProductData(shopId: shopID,page: page, limit: limit);

  }
}
