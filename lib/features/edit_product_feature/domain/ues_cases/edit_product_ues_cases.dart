import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/image_model.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/Constants/Enums/form_builder_enum.dart';
import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/shop_model.dart';
import '../repository/edit_product_repository_interface.dart';

class EditProductUesCase {
  final EditProductRepositoryInterface repositoryInterface;

  EditProductUesCase(this.repositoryInterface);

  Future<Either<CustomError, BaseModel>> callEditProduct(
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
    return repositoryInterface.editProduct(
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
    productImageDeleted: productImageDeleted,
      formData: formData
    );
  }
  Future<Either<CustomError, ProductModel>> callGetProductDetailsEdit(
      {required int productId}) {
    return repositoryInterface
        .getProductDetailsOnEdit(productId: productId)
        .then((value) => value.fold((l) => left(l), (r) {
      ProductModel model = ProductModel.fromJson(r.data);
      FormBuilderModel? formBuilderModel;
      for (var element in model.formList!) {
        if (element.inputType == FormBuilderEnum.select) {
          element.value = element.defaultValueText.isEmpty
              ? null
              : element.optionGroup!
              .where((optionElement) =>
          optionElement.id.toString() ==
              element.defaultValueText[0]["value"])
              .first;
          for (var optionElement in element.defaultValueText) {
            if (optionElement["parent_id"] != null) {
              formBuilderModel = element.editCopyWith(
                  element.optionGroup!.firstWhere((element) =>
                  element.parentId == optionElement["parent_id"]));
            }
          }
        } else if (element.inputType == FormBuilderEnum.radio) {
          element.value = element.defaultValueText.isEmpty
              ? null
              : element.optionGroup!
              .where((optionElement) =>
          optionElement.id.toString() ==
              element.defaultValueText[0]["value"])
              .first;
        } else if (element.inputType == FormBuilderEnum.checkbox) {
          if (element.defaultValueText.isEmpty) {
            element.value = null;
          } else {
            if (element.defaultValueText[0]["value"] is List) {
              List<dynamic> selectionIds =
              element.defaultValueText[0]["value"];
              List<dynamic> selectionOption = [];
              for (var elementId in selectionIds) {
                if (element.optionGroup!
                    .where(
                        (element) => element.id.toString() == elementId)
                    .isNotEmpty) {
                  selectionOption.add(element.optionGroup!
                      .where((element) =>
                  element.id.toString() == elementId)
                      .first);
                }
              }
              element.value = selectionOption;
            } else {
              element.value = [
                element.optionGroup!
                    .where((optionElement) =>
                optionElement.id.toString() ==
                    element.defaultValueText[0]["value"][0]
                        .toString())
                    .first
              ];
            }
          }
        } else if (element.inputType == FormBuilderEnum.rang) {
          element.value = {
            "to": element.defaultValueText![0]["value"][0],
            "from": element.defaultValueText![0]["value"][1],
          };
        } else {
          element.value = {element.key:element.defaultValueText[0]["value"]};
        }
      }
      if (formBuilderModel != null) {
        return right(model..formList!.add(formBuilderModel));
      } else {
        return right(model);
      }
    }));
  }

}
