import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/tags_feature/domain/model/tags_model.dart';

abstract class StoreRepositoryInterface {
  Future<Either<CustomError, BaseModel>> getMyStoreData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> getMyStoreProductData(
      {required int shopID, int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> addNewStore({
    required XFile storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    int? planId,
    required List<TagsModel> storeSubCategory,
  });

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
      int? planId,
      required List<TagsModel> storeSubCategory});
}
