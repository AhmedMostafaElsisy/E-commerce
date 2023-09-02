import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/features/Categories_feature/domain/repository_interface/category_repository_interface.dart';
import 'package:dartz/dartz.dart';

class CategoryUseCase {
  CategoryRepositoryInterface categoryRepositoryInterface;

  CategoryUseCase({required this.categoryRepositoryInterface});

  Future<Either<CustomException, List<CategoryModel>>>
      callAllCategoriesUseCase() async {
    return await categoryRepositoryInterface.getAllCategories();
  }
}
