import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../../features/Home_feature/Domain/enitiy/request_model.dart';
import '../../model/shop_model.dart';

class RouteArgument {
  String? id;
  String? sourcePage;
  String? imagePath;
  String? emailAddress;

  Widget? mainBody;
  PreferredSizeWidget? appBarWidget;

  /// Appbar
  bool? withBack;
  bool? withActions;
  bool? withAppBar;
  Widget? titleWidget;

  /// Functions
  Function()? onTap;
  String? otp;

  ///request id
  int? requestId;

  ///request Model
  RequestModel? requestModel;

  ShopModel? shopModel;
  ProductModel? productModel;

  RouteArgument(
      {this.id,
      this.sourcePage = '',
      this.appBarWidget = const PreferredSize(
          preferredSize: Size.fromHeight(0), child: SizedBox()),
      this.mainBody,
      this.titleWidget,
      this.withBack = false,
      this.withActions = false,
      this.withAppBar = false,
      // this.doctorModel,
      this.imagePath,
      this.emailAddress,
      this.onTap,
      this.requestModel,
      this.otp,
      this.requestId,
      this.shopModel,this.productModel});

  @override
  String toString() {
    return 'current route argument';
  }
}
