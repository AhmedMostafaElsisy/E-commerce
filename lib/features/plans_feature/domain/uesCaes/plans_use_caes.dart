import 'package:dartz/dartz.dart';
import '../../../../../core/Error_Handling/custom_error.dart';
import '../model/plans_model.dart';
import '../repository/plans_interface.dart';

class PlansUesCases {
  final PlansRepositoryInterface repositoryInterface;

  PlansUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<PlansModel>>> callPlansList(
      {int page = 1, int limit = 10, }) {
    return repositoryInterface
        .getPlansData(page: page, limit: limit,)
        .then((value) => value.fold(
            (l) => Left(l), (r) => right(plansListFromJson(r.data))));
  }


}
