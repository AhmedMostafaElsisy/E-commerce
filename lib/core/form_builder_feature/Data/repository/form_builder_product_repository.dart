import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/form_builder_product_interface.dart';
import '../data_scources/form_builder_data_scources.dart';

class FormBuilderProductRepository extends FormBuilderInterface {
  final FormBuilderRemoteDataSourceInterface remoteDataSourceInterface;

  FormBuilderProductRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getProductForm(
      {required int categoryId}) {
    return remoteDataSourceInterface.getProductForm(categoryId: categoryId);
  }

}
