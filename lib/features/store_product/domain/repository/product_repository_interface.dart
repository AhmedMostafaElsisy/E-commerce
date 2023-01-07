import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';

abstract class ProductRepositoryInterface  {

  Future<Either<CustomError, BaseModel>> addNewProduct(
      {required String productName,
        required String productMainPrice,
        required String productDiscountPrice,
        required String productType,
        required List<XFile> productImage,
        required String productStates,
        required String productBrand,
        required String productDescription,
        required String storeId}
  );

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
        required String productId}
  );
}
