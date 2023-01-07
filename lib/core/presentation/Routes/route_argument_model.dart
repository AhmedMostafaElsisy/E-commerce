import 'package:flutter/material.dart';

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

  ShopModel? shopModel;

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
      this.otp,
      this.requestId,
      this.shopModel});

  @override
  String toString() {
    return 'current route argument';
  }
}
