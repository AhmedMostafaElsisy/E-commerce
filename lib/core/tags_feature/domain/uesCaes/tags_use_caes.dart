import 'package:dartz/dartz.dart';
import '../../../../../core/Error_Handling/custom_error.dart';
import '../model/tags_model.dart';
import '../repository/tags_interface.dart';

class TagsUesCases {
  final TagsRepositoryInterface repositoryInterface;

  TagsUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<TagsModel>>> callTagsList(
      {int page = 1, int limit = 10, }) {
    return repositoryInterface
        .getTagsData(page: page, limit: limit,)
        .then((value) => value.fold(
            (l) => Left(l), (r) => right(TagsListFromJson(r.data))));
  }


}
