import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/features/store_feature/data/data_scoures/general_stores_remote_data_scoures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/general_stores_repository_interface.dart';

class GeneralStoresRepository extends GeneralStoresRepositoryInterface {
  final GeneralStoresRemoteDataSourceInterface remoteDataSourceInterface;

  GeneralStoresRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getGeneralStoresData(
      {int page = 1, int? limit}) {
    return remoteDataSourceInterface.getStoreData(page: page, limit: limit);
  }

  @override
  Future<Either<CustomError, BaseModel>> getGeneralStoresProductData(
      {required int shopID, int page = 1, int? limit}) {
    return remoteDataSourceInterface.getStoreProductData(
        shopId: shopID, page: page, limit: limit);
  }
}
