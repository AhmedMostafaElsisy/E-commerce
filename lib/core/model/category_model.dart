import '../../features/Categories_feature/domain/entity/category_entity.dart';
import '../Constants/Enums/exception_enums.dart';
import '../Error_Handling/custom_error.dart';
import '../Error_Handling/custom_exception.dart';

List<CategoryModel> categoriesListFromJson(List str) =>
    List<CategoryModel>.from(str.map((x) => CategoryModel.fromJson(x)));

class CategoryModel extends CategoryEntityModel {
  CategoryModel({
    required int id,
    required String name,
    required String image,
  }) : super(id: id, name: name, image: image);

  ///Todo:check the json key when integrate with the api
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return CategoryModel(
        id: json["id"],
        name: json["name"] ?? "",
        image: json["image"] ?? "",
      );
    } catch (error) {
      throw CustomException(
        error: CustomError(
          errorMassage: error.toString(),
          type: CustomStatusCodeErrorType.canNotParsing,
        ),
      );
    }
  }
}
