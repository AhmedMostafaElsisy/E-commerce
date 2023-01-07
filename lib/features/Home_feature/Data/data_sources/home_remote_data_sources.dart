import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class HomeRemoteDataSourceInterface {
  ///get requests
  Future<Either<CustomException, BaseModel>> getHomeData();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> getHomeData() async {
    try {
      // String pathUrl = "";
      // Response response = await DioHelper.getDate(url: pathUrl);
      // return right(BaseModel.fromJson(response.data));
      Map<String, dynamic> json = {};
      return right(BaseModel.fromJson(json));
    } on CustomException catch (ex) {
      return Left(ex);
    }
  }
}
