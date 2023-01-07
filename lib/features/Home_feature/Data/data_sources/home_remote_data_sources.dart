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
      Map<String, dynamic> json = {
        "code": 200,
        "massage": "success",
        "data": {
          "banners": [
            {
              "id": 1,
              "banner_image":
                  "https://img.freepik.com/free-vector/flat-supermarket-social-media-cover-template_23-2149379265.jpg?w=1800&t=st=1673101185~exp=1673101785~hmac=cbe5e51ed45219d2a5a6ebee2db8b387ae1e0585b2b3beef0910367d3765f43c",
              "title": "banner title 1",
              "description": "create your store",
              "navigation": "store",
            },
            {
              "id": 2,
              "banner_image":
                  "https://img.freepik.com/free-vector/flat-supermarket-social-media-cover-template_23-2149379265.jpg?w=1800&t=st=1673101185~exp=1673101785~hmac=cbe5e51ed45219d2a5a6ebee2db8b387ae1e0585b2b3beef0910367d3765f43c",
              "title": "banner title 2",
              "description": "create your store",
              "navigation": "store",
            },
          ],
        }
      };
      return right(BaseModel.fromJson(json));
    } on CustomException catch (ex) {
      return Left(ex);
    }
  }
}
