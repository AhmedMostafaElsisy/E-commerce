import 'package:dartz/dartz.dart';

import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/image_model.dart';
import '../../../../core/model/shop_model.dart';

abstract class EditProductRepositoryInterface {
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
      });

  Future<Either<CustomError, BaseModel>> getProductDetailsOnEdit(
      {required int productId});

}
