import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../../features/Chat_Feature/Data/chat_models/chat_user_model.dart';
import '../../../features/order_feature/domain/model/order_model.dart';
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
  int? userID;
  int? pladId;

  ShopModel? shopModel;
  ProductModel? productModel;
  bool? firstStoreCreate;
  OrderModel? orderModel;

  ChatUserModel? chatUserModel;

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
      this.chatUserModel,
      this.imagePath,
      this.emailAddress,
      this.userID,
      this.pladId,
      this.onTap,
      this.otp,
      this.requestId,
      this.shopModel,
      this.productModel,
      this.orderModel,
      this.firstStoreCreate});

  @override
  String toString() {
    return 'current route argument';
  }
}
