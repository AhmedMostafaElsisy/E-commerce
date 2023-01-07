import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/features/Categories_feature/domain/repository_interface/category_repository_interface.dart';
import 'package:dartz/dartz.dart';

import '../data_source/category_remote_data_source.dart';

class CategoryRepositoryImplementation extends CategoryRepositoryInterface {
  CategoryRemoteDataSourceInterface categoryRemoteDataSourceInterface;

  CategoryRepositoryImplementation(
      {required this.categoryRemoteDataSourceInterface});

  @override
  Future<Either<CustomException, List<CategoryModel>>>
      getAllCategories() async {
    return await categoryRemoteDataSourceInterface
        .getCategoriesData()
        .then((value) => value.fold((l) => Left(l), (r) {
              try {
                List<CategoryModel> categories = categoriesListFromJson(r.data);
                return right(categories);
              } on CustomException catch (customEx) {
                return left(customEx);
              } catch (ex) {
                return left(CustomException(
                  error: CustomError(
                    errorMassage: ex.toString(),
                    type: CustomStatusCodeErrorType.unExcepted,
                  ),
                ));
              }
            }));
  }
}
