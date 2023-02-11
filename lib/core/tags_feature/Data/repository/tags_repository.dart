import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/tags_interface.dart';
import '../data_scources/tags_remote_data_scources.dart';

class TagsRepository extends TagsRepositoryInterface {
  final TagsRemoteDataSourceInterface remoteDataSourceInterface;

  TagsRepository(this.remoteDataSourceInterface);


  @override
  Future<Either<CustomError, BaseModel>> getTagsData(
      {int page = 1, int limit = 10, }) {
    return remoteDataSourceInterface.getTags(
         page: page, limit: limit);
  }


}
