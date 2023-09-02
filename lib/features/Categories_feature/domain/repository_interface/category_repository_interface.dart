import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepositoryInterface {
  Future<Either<CustomException, List<CategoryModel>>> getAllCategories();
}
