import 'package:default_repo_app/Helpers/shared.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context, required String title, Color? color}) {
  Color backgroundColor = color ?? Colors.red;

  final snackBar = SnackBar(
    content: Text(title),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 150,
      right: getWidgetWidth(20),
      left: getWidgetWidth(20),
    ),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
