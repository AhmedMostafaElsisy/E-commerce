import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';
class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: CircularProgressIndicator(
            color: AppConstants.mainColor,
          ),
        ),
      ],
    );
  }
}
