import 'package:default_repo_app/Constants/app_constants.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';

class AppMainPage extends StatefulWidget {
  final Widget pageContent;
  final Color? backgroundColor;

  const AppMainPage({Key? key, required this.pageContent,
  this.backgroundColor = AppConstants.lightGreyBackGround}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: widget.pageContent,
      ),
    );
  }
}
