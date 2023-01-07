import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRemoteDataSourceInterface {
  Future<Either<CustomException, BaseModel>> getCategoriesData();
}

class CategoryRemoteDataSourceImplementation
    extends CategoryRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> getCategoriesData() async {
    try {
      // String pathUrl = "${ApiKeys.favoriteKey}?id?=$productId";
      // FormData data = FormData();

      // Response response = await DioHelper.postData(url: pathUrl, data: data);
      Map<String, dynamic> json = {
        "code": 200,
        "massage": "success",
        "data": [
          {
            "id": 1,
            "name": "عقارات",
            "image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
          },
          {
            "id": 2,
            "name": "سيارات",
            "image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
          },
          {
            "id": 3,
            "name": "موبايلات",
            "image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
          },
          {
            "id": 4,
            "name": "كمبيوتر",
            "image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
          },
          {
            "id": 5,
            "name": "اجهزة منزلية",
            "image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
          },
          {
            "id": 6,
            "name": "أثاث",
            "image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
          },
        ]
      };
      await Future.delayed(const Duration(seconds: 3));

      return right(BaseModel.fromJson(json));
    } on CustomException catch (ex) {
      return Left(ex);
    }
  }
}
