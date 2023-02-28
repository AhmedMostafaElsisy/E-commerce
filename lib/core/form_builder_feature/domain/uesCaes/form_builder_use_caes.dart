
import 'package:captien_omda_customer/core/form_builder_feature/domain/model/form_builder_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/Error_Handling/custom_error.dart';
import '../repository/form_builder_product_interface.dart';

class FormBuilderUesCases {
  final FormBuilderInterface repositoryInterface;

  FormBuilderUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<FormBuilderModel>>> callCategoryForm(
      {required int categoryId}) {
    return repositoryInterface
        .getProductForm(categoryId: categoryId)
        .then((value) => value.fold((l) => Left(l), (r) {
              if(r.data==[]){
                return right([]);
              }else{
                return right(formBuilderListFromJson(r.data["fields"]));

              }
            }));
  }

  Future<Either<CustomError, List<FormBuilderModel>>> callCategoryFilterForm(
      {required int categoryId}) {
    return repositoryInterface.getProductForm(categoryId: categoryId).then(
        (value) => value.fold((l) => Left(l),
            (r) => right(formFilterBuilderListFromJson(r.data["fields"]))));
  }
}
