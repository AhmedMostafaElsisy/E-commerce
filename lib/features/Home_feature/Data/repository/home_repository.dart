import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:dartz/dartz.dart';

import '../../Domain/repository/home_interface.dart';
import '../data_sources/home_remote_data_sources.dart';
import '../model/banner_model.dart';

class HomeRepository extends HomeRepositoryInterface {
  final HomeRemoteDataSourceInterface remoteDataSourceInterface;

  HomeRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomException, List<BannerModel>>> getHomeContent() {
    return remoteDataSourceInterface
        .getBanners()
        .then((value) => value.fold((l) => Left(l), (r) {
              try {
                List<BannerModel> banners = bannerListFromJson(r.data);
                return Right(banners);
              } on CustomException catch (error) {
                return left(error);
              } catch (ex) {
                return left(CustomException(
                    error: CustomError(
                  type: CustomStatusCodeErrorType.unExcepted,
                  errorMassage: ex.toString(),
                )));
              }
            }));
  }
}
