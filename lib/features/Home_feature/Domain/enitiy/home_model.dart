import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';

import '../../../../core/model/shop_model.dart';
import 'banner_model.dart';

//todo: fix data parsing on home model
class HomeModel {
  final List<BannerModel> banners;
  final List<ShopModel> stores;
  final List<ProductModel> products;

  const HomeModel({
    required this.banners,
    required this.stores,
    required this.products,
  });

  factory HomeModel.fromJson(Map<String, dynamic> jsonObject) {
    try {
      return HomeModel(
          banners: bannerListFromJson(
            jsonObject["banners"],
          ),
          stores: shopListFromJson(
            jsonObject["stores"],
          ),
          products: productListFromJson(
            jsonObject["products"],
          ));
    } catch (e) {
      throw CustomException(
        error: CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.canNotParsing,
        ),
      );
    }
  }
}
