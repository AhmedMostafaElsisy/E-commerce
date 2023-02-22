import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/shop_model.dart';
import '../repository/product_repository_interface.dart';

class ProductUesCase {
  final ProductRepositoryInterface repositoryInterface;

  ProductUesCase(this.repositoryInterface);

  Future<Either<CustomError, BaseModel>> callCreateNewProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
        required List<FormBuilderModel> formData,
      required ShopModel shopModel}) {
    return repositoryInterface.addNewProduct(
        productName: productName,
        productMainPrice: productMainPrice,
        productDiscountPrice: productDiscountPrice,
        productType: productType,
        productImage: productImage,
        productStates: productStates,
        productBrand: productBrand,
        productDescription: productDescription,
        formData: formData,
        shopModel: shopModel);
  }


  Future<Either<CustomError, ProductModel>> callGetProductDetails(
      {required int productId}) {
    return repositoryInterface.getProductDetails(productId: productId).then(
        (value) => value.fold(
            (l) => left(l), (r) => right(ProductModel.fromJson(r.data))));
  }

  Future<Either<CustomError, BaseModel>> callDeleteProduct(
      {required int productId}) {
    return repositoryInterface.deleteProductDetails(productId: productId);
  }
}
