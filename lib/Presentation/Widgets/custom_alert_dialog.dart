import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    BuildContext context, String title, List<Widget> children) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: children,
          ),
        ),
      );
    },
  );
}
