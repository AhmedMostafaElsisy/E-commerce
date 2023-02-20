import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/shop_model.dart';
import '../../domain/repository/product_repository_interface.dart';
import '../data_scoures/remote_data_scoures.dart';

class ProductRepository extends ProductRepositoryInterface {
  final ProductRemoteDataSourceInterface remoteDataSourceInterface;

  ProductRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> addNewProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required ShopModel shopModel,
        required List<FormBuilderModel> formData
      }) {
    return remoteDataSourceInterface.createProduct(
        productName: productName,
        productMainPrice: productMainPrice,
        productDiscountPrice: productDiscountPrice,
        productType: productType,
        productImage: productImage,
        productStates: productStates,
        productBrand: productBrand,
        productDescription: productDescription,
        shopModel: shopModel,
    formData: formData
    );
  }

  @override
  Future<Either<CustomError, BaseModel>> editProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      List<XFile>? productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required String storeId,
      required String productId,
        required ShopModel shopModel
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
        productImage: productImage);
  }

  @override
  Future<Either<CustomError, BaseModel>> deleteProductDetails({required int productId}) {
    return remoteDataSourceInterface.deleteProductDetails(productId: productId);
  }

  @override
  Future<Either<CustomError, BaseModel>> getProductDetails({required int productId}) {
    return remoteDataSourceInterface.getProductDetails(productId: productId);

  }
}
