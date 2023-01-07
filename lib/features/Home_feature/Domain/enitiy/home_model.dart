import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';

import 'banner_model.dart';

//todo: fix data parsing on home model
class HomeModel {
  final List<BannerModel> banners;

  const HomeModel({required this.banners});

  factory HomeModel.fromJson(Map<String, dynamic> jsonObject) {
    try {
      return HomeModel(banners: bannerListFromJson(jsonObject["Banners"]));
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
