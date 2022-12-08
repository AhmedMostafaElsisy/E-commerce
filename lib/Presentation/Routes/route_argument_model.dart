import 'package:flutter/material.dart';

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

  RouteArgument(
      {this.id,
      this.sourcePage = '',
      this.appBarWidget = const PreferredSize(
          child: SizedBox(), preferredSize: Size.fromHeight(0)),
      this.mainBody,
      this.titleWidget,
      this.withBack = false,
      this.withActions = false,
      this.withAppBar = false,
      // this.doctorModel,
      this.imagePath,
      this.emailAddress,
      this.onTap});

  @override
  String toString() {
    return 'current route argument';
  }
}
