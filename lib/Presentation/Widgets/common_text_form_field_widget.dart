import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'common_icon_widget.dart';

class CommonTextFormFieldClass {
  static Widget textFormField(
    BuildContext context, {
    String? hintText,
    TextEditingController? controller,
    IconData? prefixIcon,
    Color? prefixIconColor,
    int minLines = 1,
    int maxLines = 1,
    double radius = 50.0,
    Color borderColor = Colors.transparent,
    Color bgColor = Colors.transparent,
    Widget? suffixIcon,
    bool withSuffix = false,
    bool obscureText = false,
    bool enabled = true,
    Function()? onTap,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    IconData icon = prefixIcon ?? FontAwesome5.user;
    Color prefixColor = prefixIconColor ?? borderColor;

    return Container(
      width: SharedText.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: SharedText.screenWidth * 0.015),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              minLines: minLines,
              obscureText: obscureText,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onTap: onTap,
              enabled: enabled,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: commonIcon(icon, prefixColor, 20.0, 40.0),
              ),
              validator: validator,
            ),
          ),
          if (withSuffix) suffixIcon!
        ],
      ),
    );
  }
}
