import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/image_model.dart';
import '../../../../core/model/shop_model.dart';
import '../../domain/repository/edit_product_repository_interface.dart';
import '../data_scoures/remote_data_scoures.dart';

class EditProductRepository extends EditProductRepositoryInterface {
  final EditProductRemoteDataSourceInterface remoteDataSourceInterface;

  EditProductRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> editProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      List<ImageModel>? productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required String storeId,
      required String productId,
        required ShopModel shopModel,
        required List<FormBuilderModel> formData,
        required List<String> productImageDeleted,

      }) {
    return remoteDataSourceInterface.editProduct(
        productName: productName,
        productMainPrice: productMainPrice,
        productDiscountPrice: productDiscountPrice,
        productType: productType,
        productStates: productStates,
        productBrand: productBrand,
        productDescription: productDescription,
        storeId: storeId,
        productId: productId,
        shopModel: shopModel,
        productImage: productImage,
    formData: formData,
      productImageDeleted: productImageDeleted
    );
  }

  @override
  Future<Either<CustomError, BaseModel>> getProductDetailsOnEdit({required int productId}) {
    return remoteDataSourceInterface.getProductDetailsOnEdit(productId: productId);

  }
}
