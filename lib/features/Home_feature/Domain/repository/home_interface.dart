import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/features/Home_feature/Data/model/banner_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Base_interface/base_interface.dart';

abstract class HomeRepositoryInterface extends BaseInterface {
  Future<Either<CustomException, List<BannerModel>>> getHomeContent();
}
