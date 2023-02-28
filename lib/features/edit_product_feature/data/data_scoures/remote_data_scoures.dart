import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Constants/Enums/form_builder_enum.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/model/image_model.dart';
import '../../../../core/model/shop_model.dart';

abstract class EditProductRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> editProduct({
    required String productName,
    required String productMainPrice,
    required String productDiscountPrice,
    required String productType,
    List<ImageModel>? productImage,
    required List<String> productImageDeleted,
    required String productStates,
    required String productBrand,
    required String productDescription,
    required String storeId,
    required String productId,
    required ShopModel shopModel,
    required List<FormBuilderModel> formData,
  });

  Future<Either<CustomError, BaseModel>> getProductDetailsOnEdit(
      {required int productId});
}

class EditProductRemoteDataSourceImpl
    extends EditProductRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> editProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      List<ImageModel>? productImage,
      required List<String> productImageDeleted,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required String storeId,
      required String productId,
      required List<FormBuilderModel> formData,
      required ShopModel shopModel}) async {
    try {
      String pathUrl = ApiKeys.productUpdateKey;

      FormData staticData = FormData();
      List<ImageModel> imageFileGroup = productImage!
          .where((imageElement) => imageElement.fileImage != null)
          .toList();
      var photoList = [];
      for (var element in imageFileGroup) {
        photoList.add(await MultipartFile.fromFile(
          element.fileImage!,
          filename: element.fileImage!.split("/").last.toString(),
        ));
      }
      var deletedImage = [];
      for (var element in productImageDeleted) {
        deletedImage.add({"id": element});
      }
      var formDataCollection = [];
      for (var formElement in formData) {
        Map<String, dynamic> singleItem = {};
        if (formElement.inputType == FormBuilderEnum.rang) {
          List<String> values = [];
          values.add(formElement.value["to"]);
          values.add(formElement.value["from"]);
          singleItem = {
            "field_id": formElement.id,
            "key": formElement.key,
            "value": values,
          };
        } else if (formElement.inputType == FormBuilderEnum.radio) {
          if (formElement.value != null) {
            singleItem = {
              "field_id": formElement.id,
              "key": formElement.key,
              "value": formElement.value.id,
              "option_key": [formElement.value.key],
            };
          }
        } else if (formElement.inputType == FormBuilderEnum.checkbox) {
          if (formElement.value != null) {
            List<String> values = [];
            for (int i = 0; i < formElement.value.length; i++) {
              values.add(formElement.value[i].id.toString());
            }
            List<String> optionKeys = [];
            for (int i = 0; i < formElement.value.length; i++) {
              optionKeys.add(formElement.value[i].key);
            }
            singleItem = {
              "field_id": formElement.id,
              "key": formElement.key,
              "value": values,
              "option_key": optionKeys,
            };
          }
        } else if (formElement.inputType == FormBuilderEnum.select) {
          singleItem = {
            "field_id": formElement.id,
            "key": formElement.key,
            "value": formElement.value.id,
            "option_key": [formElement.value.key],
          };
        } else {
          singleItem = {
            "key": formElement.key,
            "field_id": formElement.id,
            "value": formElement.value[formElement.key],
          };
        }
        formDataCollection.add(singleItem);
      }
      Map<String, dynamic> postData = {
        "name": productName,
        "description": productDescription,
        "price": productMainPrice,
        "discount": productDiscountPrice,
        "type": productType,
        "category_id": productBrand,
        "city_id": shopModel.city!.id,
        "area_id": shopModel.area!.id,
        "store_id": shopModel.id,
        "weight": 0,
        "product_id": productId,
        "form": formDataCollection,
        'images': deletedImage,
        'new_image': photoList,
      };
      staticData = FormData.fromMap(
        postData,
        ListFormat.multiCompatible,
      );
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getProductDetailsOnEdit(
      {required int productId}) async {
    try {
      String pathUrl = "${ApiKeys.productOnEditKey}?product_id=$productId";

      Response response = await DioHelper.getDate(
        url: pathUrl,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
