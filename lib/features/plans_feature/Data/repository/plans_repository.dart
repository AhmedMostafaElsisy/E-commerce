import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/plans_interface.dart';
import '../data_scources/plans_remote_data_scources.dart';

class PlansRepository extends PlansRepositoryInterface {
  final PlansRemoteDataSourceInterface remoteDataSourceInterface;

  PlansRepository(this.remoteDataSourceInterface);


  @override
  Future<Either<CustomError, BaseModel>> getPlansData(
      {int page = 1, int limit = 10, }) {
    return remoteDataSourceInterface.getPlans(
         page: page, limit: limit);
  }


}
