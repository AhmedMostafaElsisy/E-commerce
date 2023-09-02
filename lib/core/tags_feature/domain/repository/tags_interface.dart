import 'package:dartz/dartz.dart';

import '../../../../../core/Error_Handling/custom_error.dart';
import '../../../../../core/model/base_model.dart';

abstract class TagsRepositoryInterface {

  Future<Either<CustomError, BaseModel>> getTagsData(
      {int page = 1, int limit = 10});

 
}
