import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class GetCategoryFailedState extends CategoryState {
  CustomError error;

  GetCategoryFailedState({required this.error});
}

class GetCategorySuccessState extends CategoryState {
  List<CategoryModel> categories;

  GetCategorySuccessState({required this.categories});
}
