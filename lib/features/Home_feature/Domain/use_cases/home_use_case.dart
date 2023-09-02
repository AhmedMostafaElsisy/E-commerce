import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/features/Home_feature/Data/model/banner_model.dart';
import 'package:dartz/dartz.dart';

import '../repository/home_interface.dart';

class HomeUesCases {
  final HomeRepositoryInterface repositoryInterface;

  HomeUesCases(this.repositoryInterface);

  Future<Either<CustomException, List<BannerModel>>> callHomeContent() {
    return repositoryInterface
        .getHomeContent()
        .then((value) => value.fold((l) => Left(l), (r) => right(r)));
  }
}
