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
          "stores": [
            {
              "id": 1,
              "shop_name": "متجر الكتروني",
              "shop_image":
                  "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
              "category": "electronic",
              "location": "cairo",
              "phone": "0100000",
              "email": "abc@gmail.com",
              "owner_name": "ahmed",
              "city": "cairo",
              "area": "cairo",
              "sub_category": "electronic , hardware",
              "rate": "2"
            },
            {
              "id": 1,
              "shop_name": "متجر الكتروني",
              "shop_image":
                  "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
              "category": "electronic",
              "location": "cairo",
              "phone": "0100000",
              "email": "abc@gmail.com",
              "owner_name": "ahmed",
              "city": "cairo",
              "area": "cairo",
              "sub_category": "electronic , hardware",
              "rate": "2"
            },
          ],
          "products": [
            {
              "id": 1,
              "product_name": "product 1",
              "product_image":
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
              "price": "1500",
              "description": "electronic , photos",
              "time": "15h",
              "is_fav": true,
              "shop": {
                "id": 1,
                "shop_name": "متجر الكتروني",
                "shop_image":
                    "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
                "category": "electronic",
                "location": "cairo"
              }
            },
            {
              "id": 2,
              "product_name": "product 2",
              "product_image":
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
              "price": "1500",
              "description": "electronic , photos",
              "time": "15h",
              "is_fav": true,
              "shop": {
                "id": 1,
                "shop_name": "متجر الكتروني",
                "shop_image":
                    "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
                "category": "electronic",
                "location": "cairo"
              }
            },
            {
              "id": 3,
              "product_name": "product 3",
              "product_image":
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
              "price": "1500",
              "description": "electronic , photos",
              "time": "15h",
              "is_fav": false,
              "shop": {
                "id": 1,
                "shop_name": "متجر الكتروني",
                "shop_image":
                    "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
                "category": "electronic",
                "location": "cairo"
              }
            },
            {
              "id": 4,
              "product_name": "product 4",
              "product_image":
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
              "price": "1500",
              "description": "electronic , photos",
              "time": "15h",
              "is_fav": true,
              "shop": {
                "id": 1,
                "shop_name": "متجر الكتروني",
                "shop_image":
                    "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
                "category": "electronic",
                "location": "cairo"
              }
            },
            {
              "id": 5,
              "product_name": "product 5",
              "product_image":
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
              "price": "1500",
              "description": "electronic , photos",
              "time": "15h",
              "is_fav": true,
              "shop": {
                "id": 1,
                "shop_name": "متجر الكتروني",
                "shop_image":
                    "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
                "category": "electronic",
                "location": "cairo"
              }
            },
            {
              "id": 6,
              "product_name": "product 6",
              "product_image":
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
              "price": "1500",
              "description": "electronic , photos",
              "time": "15h",
              "is_fav": false,
              "shop": {
                "id": 1,
                "shop_name": "متجر الكتروني",
                "shop_image":
                    "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
                "category": "electronic",
                "location": "cairo"
              }
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
