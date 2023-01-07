import 'package:captien_omda_customer/features/Categories_feature/domain/use_case/category_use_case.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/category_model.dart';

class CategoriesCubit extends Cubit<CategoryState> {
  CategoryUseCase categoryUseCase;

  CategoriesCubit(this.categoryUseCase) : super(CategoryInitState());

  List<CategoryModel> categories = [];

  getAllCategories() {
    emit(CategoryLoadingState());
    categoryUseCase.callAllCategoriesUseCase().then(
          (value) => value.fold(
              (l) => emit(
                    GetCategoryFailedState(
                      error: l.error,
                    ),
                  ), (r) {
            categories.addAll(r);
            emit(
              GetCategorySuccessState(
                categories: r,
              ),
            );
          }),
        );
  }
}
