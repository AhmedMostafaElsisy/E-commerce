import '../../features/Categories_feature/domain/entity/category_entity.dart';
import '../Constants/Enums/exception_enums.dart';
import '../Error_Handling/custom_error.dart';
import '../Error_Handling/custom_exception.dart';

List<CategoryModel> categoriesListFromJson(List str) =>
    List<CategoryModel>.from(str.map((x) => CategoryModel.fromJson(x)));

class CategoryModel extends CategoryEntityModel {
  CategoryModel(
      {required int id,
      required String name,
      required String image,
      required String slug,
      required bool active})
      : super(id: id, name: name, image: image, active: active, slug: slug);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return CategoryModel(
          id: json["id"],
          name: json["name"] ?? "",
          image: json["image"] ?? "",
          slug: json["slug"] ?? "",
          active: json["activated"] == null
              ? false
              : json["activated"] == 1
                  ? true
                  : false);
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
