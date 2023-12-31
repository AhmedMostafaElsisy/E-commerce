import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/features/Home_feature/Data/model/banner_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeContentLoadingState extends HomeState {}

class HomeGetContentSuccessState extends HomeState {
  List<BannerModel> banners;

  HomeGetContentSuccessState(this.banners);
}

class HomeGetContentFailedState extends HomeState {
  CustomError error;

  HomeGetContentFailedState(this.error);
}
