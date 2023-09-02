import 'dart:async';

import 'package:captien_omda_customer/core/Constants/Enums/form_builder_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/model/shop_model.dart';

abstract class ProductRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> createProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required ShopModel shopModel,
      required List<FormBuilderModel> formData});



  Future<Either<CustomError, BaseModel>> getProductDetails(
      {required int productId});

  Future<Either<CustomError, BaseModel>> deleteProductDetails(
      {required int productId});
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> createProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required ShopModel shopModel,
      required List<FormBuilderModel> formData}) async {
    try {
      String pathUrl = ApiKeys.addProductKey;

      FormData staticData = FormData();
      var photoList = [];
      for (var element in productImage) {
        photoList.add(await MultipartFile.fromFile(
          element.path,
          filename: element.path.split("/").last.toString(),
        ));
      }
      var formDataCollection = [];
      for (var formElement
          in formData.where((element) => element.value != null)) {
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
          singleItem = {
            "field_id": formElement.id,
            "key": formElement.key,
            "value": formElement.value.id,
            "option_key": [formElement.value.key],
          };
        } else if (formElement.inputType == FormBuilderEnum.checkbox) {
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
        "images": photoList,
        "price": productMainPrice,
        "discount": productDiscountPrice,
        "type": productType,
        "category_id": productBrand,
        "city_id": shopModel.city!.id,
        "area_id": shopModel.area!.id,
        "store_id": shopModel.id,
        "weight": 0,
        "form": formDataCollection,
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
  Future<Either<CustomError, BaseModel>> deleteProductDetails(
      {required int productId}) async {
    try {
      String pathUrl = ApiKeys.deleteProductKey;
      FormData staticData = FormData();
      staticData.fields.add(MapEntry('product_id', productId.toString()));
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
  Future<Either<CustomError, BaseModel>> getProductDetails(
      {required int productId}) async {
    try {
      String pathUrl = "${ApiKeys.showProductKey}?product_id=$productId";

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
