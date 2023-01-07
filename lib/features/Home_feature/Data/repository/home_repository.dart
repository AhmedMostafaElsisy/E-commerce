import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/home_model.dart';
import 'package:dartz/dartz.dart';

import '../../Domain/repository/home_interface.dart';
import '../data_sources/home_remote_data_sources.dart';

class HomeRepository extends HomeRepositoryInterface {
  final HomeRemoteDataSourceInterface remoteDataSourceInterface;

  HomeRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomException, HomeModel>> getHomeContent() {
    return remoteDataSourceInterface
        .getHomeData()
        .then((value) => value.fold((l) => Left(l), (r) {
              try {
                HomeModel homeParsedModel = HomeModel.fromJson(r.data);
                return Right(homeParsedModel);
              } catch (ex) {
                return left(CustomException(
                    error: CustomError(
                  type: CustomStatusCodeErrorType.unExcepted,
                )));
              }
            }));
  }
}
